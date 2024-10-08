//!
//! Implements a simple polling button driver that uses a debouncing technique.
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const Debounced_Button_Options = struct {
    /// The active state for the button. Use `.high` for active-high, `.low` for active-low.
    active_state: mdf.base.Digital_IO.State,

    /// Optional filter depth for debouncing. If `null` is passed, 16 samples are used to debounce the button,
    /// otherwise the given number of samples is used.
    filter_depth: ?comptime_int = null,

    /// Which digital i/o interface should be used.
    Digital_IO: type = mdf.base.Digital_IO,
};

///
/// A button sensor that uses a digital i/o to read the button state.
///
/// It uses a simple filtering technique to debounce glitches on the digital status:
///
/// A filter integer is used that stores the last N samples of the button and the button
/// is considered pressed if at least a single bit in the filter is set.
///
/// Each poll, the filter integer is shifted by one bit and the new state is inserted. This
/// way, a simple "was it pressed in the last N polls" function is implemented.
///
pub fn Debounced_Button(comptime options: Debounced_Button_Options) type {
    return struct {
        const Button = @This();
        const Filter_Int = std.meta.Int(.unsigned, options.filter_depth orelse 16);

        io: options.Digital_IO,
        filter_buffer: Filter_Int,

        pub fn init(io: options.Digital_IO) !Button {
            try io.set_bias(options.active_state.invert());
            try io.set_direction(.input);
            return Button{
                .io = io,
                .filter_buffer = 0,
            };
        }

        /// Polls for the button state. Returns the change  feventor the button if any.
        pub fn poll(self: *Button) !Event {
            const state = try self.io.read();
            const active_unfiltered = (state == options.active_state);

            const previous_debounce = self.filter_buffer;
            self.filter_buffer <<= 1;
            if (active_unfiltered) {
                self.filter_buffer |= 1;
            }

            if (active_unfiltered and previous_debounce == 0) {
                return .pressed;
            } else if (!active_unfiltered and self.filter_buffer == 0 and previous_debounce != 0) {
                return .released;
            } else {
                return .idle;
            }
        }

        /// Returns `true` when the button is pressed.
        ///
        /// NOTE: Will only be updated when `.poll()` is called!
        pub fn is_pressed(self: *Button) bool {
            return (self.filter_buffer != 0);
        }
    };
}

pub const Event = enum {
    /// Nothing has changed.
    idle,

    /// The button was pressed. Will only trigger once per press.
    /// Use `Button.is_pressed()` to check if the button is currently held.
    pressed,

    /// The button was released. Will only trigger once per release.
    /// Use `Button.is_pressed()` to check if the button is currently held.
    released,
};

test Debounced_Button {
    const Button = Debounced_Button(.{
        .active_state = .low,
        .filter_depth = 4,
    });

    var button_input = mdf.base.Digital_IO.TestDevice.init(.input, .high);

    var button = try Button.init(button_input.digital_io());

    // Basic test sequence:
    //                                          1                             2                             3
    //            0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //    Input   ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //    State   ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┏━━┓  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //  Pressed   ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┃  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┏━━┓  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    // Released   ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┃  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆

    {

        // Button should be stable in its state in idle:
        for (0..10) |_| {
            try std.testing.expectEqual(.idle, try button.poll());
            try std.testing.expectEqual(false, button.is_pressed());
        }

        button_input.state = .low;

        try std.testing.expectEqual(.pressed, try button.poll());
        try std.testing.expectEqual(true, button.is_pressed());

        // Button should be stable in its state in idle:
        for (0..10) |_| {
            try std.testing.expectEqual(.idle, try button.poll());
            try std.testing.expectEqual(true, button.is_pressed());
        }

        button_input.state = .high;

        // The button will stay in "high" state for three successive polls:
        for (0..3) |_| {
            try std.testing.expectEqual(.idle, try button.poll());
            try std.testing.expectEqual(true, button.is_pressed());
        }

        // then it should yield a ".released" event:
        try std.testing.expectEqual(.released, try button.poll());
        try std.testing.expectEqual(false, button.is_pressed());

        // afterwards it has to be stable again:
        for (0..10) |_| {
            try std.testing.expectEqual(.idle, try button.poll());
            try std.testing.expectEqual(false, button.is_pressed());
        }
    }

    // Test sequence for two short consecutive signals:
    //                                          1
    //            0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━┓  ┏━━┓  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //    Input   ┆  ┃  ┃  ┃  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┗━━┛  ┗━━┛  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┏━━━━━━━━━━━━━━━━━┓  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //    State   ┆  ┃  ┆  ┆  ┆  ┆  ┆  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━┛  ┆  ┆  ┆  ┆  ┆  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┏━━┓  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //  Pressed   ┆  ┃  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━┛  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┏━━┓  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    // Released   ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┃  ┃  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    //          ╍╍━━━━━━━━━━━━━━━━━━━━━┛  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━╍╍
    //            ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆  ┆
    {
        button_input.state = .low;

        try std.testing.expectEqual(.pressed, try button.poll());
        try std.testing.expectEqual(true, button.is_pressed());

        button_input.state = .high;

        try std.testing.expectEqual(.idle, try button.poll());
        try std.testing.expectEqual(true, button.is_pressed());

        button_input.state = .low;

        try std.testing.expectEqual(.idle, try button.poll());
        try std.testing.expectEqual(true, button.is_pressed());

        button_input.state = .high;

        // The button will stay in "high" state for three successive polls:
        for (0..3) |_| {
            try std.testing.expectEqual(.idle, try button.poll());
            try std.testing.expectEqual(true, button.is_pressed());
        }

        // then it should yield a ".released" event:
        try std.testing.expectEqual(.released, try button.poll());
        try std.testing.expectEqual(false, button.is_pressed());

        // afterwards it has to be stable again:
        for (0..20) |_| {
            try std.testing.expectEqual(.idle, try button.poll());
            try std.testing.expectEqual(false, button.is_pressed());
        }
    }
}

// waveform # sequence 1:
// Input    | HHHHHHHHHHLLLLLLLLLLLHHHHHHHHHHHHHH
// State    | LLLLLLLLLLHHHHHHHHHHHHHHLLLLLLLLLLL
// Pressed  | LLLLLLLLLLHLLLLLLLLLLLLLLLLLLLLLLLL
// Released | LLLLLLLLLLLLLLLLLLLLLLLLHLLLLLLLLLL

// waveform # sequence 2:

// Input    | HLHLHHHHHHHHHHHHHH
// State    | LHHHHHHLLLLLLLLLLL
// Pressed  | LHLLLLLLLLLLLLLLLL
// Released | LLLLLLLHLLLLLLLLLL
