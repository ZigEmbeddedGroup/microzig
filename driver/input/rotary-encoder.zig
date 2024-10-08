//!
//! Implements a bounce-free decoder for rotary encoders
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const Rotary_Encoder_Options = struct {
    /// Which digital i/o interface should be used.
    Digital_IO: type = mdf.base.Digital_IO,
};

pub fn Rotary_Encoder(comptime options: Rotary_Encoder_Options) type {
    return struct {
        const Encoder = @This();

        const Digital_IO = options.Digital_IO;

        a: Digital_IO,
        b: Digital_IO,

        last_a: mdf.base.Digital_IO.State,
        last_b: mdf.base.Digital_IO.State,

        pub fn init(
            a: Digital_IO,
            b: Digital_IO,
            idle_state: mdf.base.Digital_IO.State,
        ) !Encoder {
            try a.set_direction(.input);
            try b.set_direction(.input);
            try a.set_bias(idle_state);
            try b.set_bias(idle_state);
            return Encoder{
                .a = a,
                .b = b,
                .last_a = try a.read(),
                .last_b = try b.read(),
            };
        }

        pub fn poll(enc: *Encoder) !Event {
            var a = try enc.a.read();
            var b = try enc.b.read();
            defer enc.last_a = a;
            defer enc.last_b = b;

            const enable = a.value() ^ b.value() ^ enc.last_a.value() ^ enc.last_b.value();
            const direction = a.value() ^ enc.last_b.value();

            if (enable != 0) {
                if (direction != 0) {
                    return .increment;
                } else {
                    return .decrement;
                }
            } else {
                return .idle;
            }
        }
    };
}

pub const Event = enum(i2) {
    /// No change since the last decoding happened
    idle = 0,
    /// The quadrature signal incremented a step.
    increment = 1,
    /// The quadrature signal decremented a step.
    decrement = -1,
    /// The quadrature signal skipped a sequence point and entered a invalid state.
    @"error" = -2,
};

test Rotary_Encoder {
    var a = mdf.base.Digital_IO.TestDevice.init(.output, .high);
    var b = mdf.base.Digital_IO.TestDevice.init(.output, .high);

    var encoder = try Rotary_Encoder(.{}).init(
        a.digital_io(),
        b.digital_io(),
        .high,
    );

    // test for correct initialization:
    try std.testing.expectEqual(.input, a.dir);
    try std.testing.expectEqual(.input, b.dir);

    // test correct default state:
    for (0..10) |_| {
        try std.testing.expectEqual(.idle, try encoder.poll());
    }

    a.state = .low;

    try std.testing.expectEqual(.increment, try encoder.poll());
    try std.testing.expectEqual(.idle, try encoder.poll());

    a.state = .high;

    try std.testing.expectEqual(.decrement, try encoder.poll());
    try std.testing.expectEqual(.idle, try encoder.poll());

    b.state = .low;

    try std.testing.expectEqual(.decrement, try encoder.poll());
    try std.testing.expectEqual(.idle, try encoder.poll());

    b.state = .high;

    try std.testing.expectEqual(.increment, try encoder.poll());
    try std.testing.expectEqual(.idle, try encoder.poll());

    // Generate "positive" quadrature signal:
    for (0..100) |_| {
        a.state = a.state.invert();

        try std.testing.expectEqual(.increment, try encoder.poll());
        try std.testing.expectEqual(.idle, try encoder.poll());

        b.state = b.state.invert();

        try std.testing.expectEqual(.increment, try encoder.poll());
        try std.testing.expectEqual(.idle, try encoder.poll());
    }

    // Generate "negative" quadrature signal:
    for (0..100) |_| {
        b.state = b.state.invert();

        try std.testing.expectEqual(.decrement, try encoder.poll());
        try std.testing.expectEqual(.idle, try encoder.poll());

        a.state = a.state.invert();

        try std.testing.expectEqual(.decrement, try encoder.poll());
        try std.testing.expectEqual(.idle, try encoder.poll());
    }
}
