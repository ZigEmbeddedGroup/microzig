const std = @import("std");
const mdf = @import("../framework.zig");

// inspired by https://github.com/smart-leds-rs/ws2812-spi-rs/blob/68d98bf9c7f10bc852bace0f3fd5af2a1cef51a7/src/lib.rs

/// WS2812 leds driver. The device should output at a frequency between 2MHz and 3.8MHz. While no
/// bytes are written the output pin **must** be low.
pub fn WS2812(options: struct {
    max_led_count: usize = 1,
    Datagram_Device: type = mdf.base.Datagram_Device,
    Clock_Device: type = mdf.base.Clock_Device,
}) type {
    return struct {
        const Self = @This();

        // we can fit two bytes into one bit
        const buffer_size = options.max_led_count * 24 / 2;

        dev: options.Datagram_Device,
        clock_dev: options.Clock_Device,
        next_write_time: ?mdf.time.Absolute = null,
        buffer: [buffer_size]u8 = undefined,

        /// Initializes the driver.
        pub fn init(dev: options.Datagram_Device, clock_dev: options.Clock_Device) Self {
            return .{
                .dev = dev,
                .clock_dev = clock_dev,
            };
        }

        /// Writes the given colors in order to the device. The slice len **must** be less than the maximum led count.
        pub fn write(self: *Self, colors: []const Color) !void {
            std.debug.assert(colors.len <= options.max_led_count);

            // ensures that a reset takes place between writes
            if (self.next_write_time) |next_write_time| {
                const now = self.clock_dev.get_time_since_boot();
                if (!next_write_time.is_reached_by(now)) {
                    self.clock_dev.sleep_us(next_write_time.diff(now).to_us());
                }
            }

            const patterns: [4]u8 = .{ 0b1000_1000, 0b1000_1110, 0b1110_1000, 0b1110_1110 };

            var i: usize = 0;
            for (colors) |color| {
                const bytes: [3]u8 = .{ color.g, color.r, color.b };
                for (&bytes) |byte| {
                    var remaining = byte;
                    for (0..4) |_| {
                        const bits: u2 = @intCast((remaining & 0b1100_0000) >> 6);
                        self.buffer[i] = patterns[bits];
                        i += 1;
                        remaining <<= 2;
                    }
                }
            }

            try self.dev.connect();
            defer self.dev.disconnect();

            try self.dev.write(self.buffer[0..i]);

            self.next_write_time = self.clock_dev.make_timeout_us(300);
        }
    };
}

pub const Color = struct {
    r: u8,
    g: u8,
    b: u8,
};
