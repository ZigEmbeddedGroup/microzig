//!
//! Implements a bounce-free decoder for rotary encoders
//!

const std = @import("std");
const mdf = @import("../framework.zig");

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

pub const RotaryEncoder = RotaryEncoder_Generic(mdf.base.DigitalIO);

pub fn RotaryEncoder_Generic(comptime DigitalIO: type) type {
    return struct {
        const Encoder = @This();

        a: DigitalIO,
        b: DigitalIO,

        last_a: mdf.base.DigitalIO.State,
        last_b: mdf.base.DigitalIO.State,

        pub fn init(
            a: DigitalIO,
            b: DigitalIO,
            idle_state: mdf.base.DigitalIO.State,
        ) !Encoder {
            try a.set_direction(.input);
            try a.set_direction(.input);
            try a.set_bias(idle_state);
            return Encoder{
                .a = a,
                .b = b,
                .last_a = a.read(),
                .last_b = b.read(),
            };
        }

        pub fn tick(enc: *Encoder) Event {
            var a = enc.a.read();
            var b = enc.b.read();
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

test RotaryEncoder {
    var a = mdf.base.DigitalIO.TestDevice.init(.output, .high);
    var b = mdf.base.DigitalIO.TestDevice.init(.output, .high);

    var encoder = try RotaryEncoder.init(a.digital_io(), b.digital_io(), .high);

    _ = encoder.tick();
}
