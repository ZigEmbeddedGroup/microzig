const micro = @import("microzig");

pub const Event = enum {
    /// No change since the last decoding happened
    idle,
    /// The quadrature signal incremented a step.
    increment,
    /// The quadrature signal decremented a step.
    decrement,
    /// The quadrature signal skipped a sequence point and entered a invalid state.
    @"error",
};

pub fn Decoder(comptime pin_a: type, comptime pin_b: type) type {
    return struct {
        const Self = @This();

        last_a: micro.gpio.State,
        last_b: micro.gpio.State,

        pub fn init() Self {
            pin_a.init();
            pin_b.init();
            return Self{
                .last_a = pin_a.read(),
                .last_b = pin_b.read(),
            };
        }

        pub fn tick(self: *Self) Event {
            var a = pin_a.read();
            var b = pin_b.read();
            defer self.last_a = a;
            defer self.last_b = b;

            const enable = a.value() ^ b.value() ^ self.last_a.value() ^ self.last_b.value();
            const direction = a.value() ^ self.last_b.value();

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
