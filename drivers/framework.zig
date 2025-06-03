//!
//! The driver framework provides device-independent drivers for peripherials supported by MicroZig.
//!
const std = @import("std");

pub const display = struct {
    pub const sh1106 = @import("display/sh1106.zig");
    pub const ssd1306 = @import("display/ssd1306.zig");
    pub const st77xx = @import("display/st77xx.zig");
    pub const hd44780 = @import("display/hd44780.zig");

    // Export generic drivers:
    pub const SH1106 = sh1106.SH1106;
    pub const SSD1306_I2C = ssd1306.SSD1306_I2C;
    pub const ST7735 = st77xx.ST7735;
    pub const ST7789 = st77xx.ST7789;
    pub const HD44780 = hd44780.HD44780;

    // Export color types:
    pub const colors = @import("display/colors.zig");
};

pub const input = struct {
    pub const rotary_encoder = @import("input/rotary-encoder.zig");
    pub const keyboard_matrix = @import("input/keyboard-matrix.zig");
    pub const debounced_button = @import("input/debounced-button.zig");

    // Export generic drivers:
    pub const Key = keyboard_matrix.Key;
    pub const Keyboard_Matrix = keyboard_matrix.Keyboard_Matrix;
    pub const Debounced_Button = debounced_button.Debounced_Button;
    pub const Rotary_Encoder = rotary_encoder.Rotary_Encoder;

    pub const touch = struct {
        // const xpt2046 = @import("input/touch/xpt2046.zig");
    };
};

pub const led = struct {
    pub const ws2812 = @import("led/ws2812.zig");

    pub const WS2812 = ws2812.WS2812;
};

pub const sensor = struct {
    pub const TMP117 = @import("sensor/TMP117.zig").TMP117;
    pub const ICM_20948 = @import("sensor/ICM-20948.zig").ICM_20948;
};

pub const stepper = struct {
    const s = @import("stepper/stepper.zig");
    pub const A4988 = s.Stepper(s.A4988);
    pub const DRV8825 = s.Stepper(s.DRV8825);
    pub const ULN2003 = @import("stepper/ULN2003.zig").ULN2003;
};

pub const IO_expander = struct {
    pub const pcf8574 = @import("io_expander/pcf8574.zig");
    pub const PCF8574 = pcf8574.PCF8574;

    pub const pca9685 = @import("io_expander/pca9685.zig");
    pub const PCA9685 = pca9685.PCA9685;
};

pub const wireless = struct {
    pub const cyw43_bus = @import("wireless/cyw43/bus.zig");
    pub const cyw43_runner = @import("wireless/cyw43/runner.zig");
    pub const Cyw43_Spi = cyw43_bus.Cyw43_Spi;
    pub const Cyw43_Bus = cyw43_bus.Cyw43_Bus;
    pub const Cyw43_Runner = cyw43_runner.Cyw43_Runner;
    // pub const sx1278 = @import("wireless/sx1278.zig");
};

pub const time = struct {
    ///
    /// An absolute point in time since the startup of the device.
    ///
    /// NOTE: Using an enum to make it a distinct type, the underlying number is
    ///       time since boot in microseconds.
    ///
    pub const Absolute = enum(u64) {
        _,

        pub fn from_us(us: u64) Absolute {
            return @as(Absolute, @enumFromInt(us));
        }

        pub fn to_us(abs: Absolute) u64 {
            return @intFromEnum(abs);
        }

        pub fn is_reached_by(deadline: Absolute, point: Absolute) bool {
            return deadline.to_us() <= point.to_us();
        }

        pub fn diff(future: Absolute, past: Absolute) Duration {
            return Duration.from_us(future.to_us() - past.to_us());
        }

        pub fn add_duration(abs: Absolute, dur: Duration) Absolute {
            return Absolute.from_us(abs.to_us() + dur.to_us());
        }
    };

    ///
    /// A duration with microsecond precision.
    ///
    /// NOTE: Using an `enum` type here prevents type confusion with other
    ///       related or unrelated integer-like types.
    ///
    pub const Duration = enum(u64) {
        _,

        pub fn from_us(us: u64) Duration {
            return @as(Duration, @enumFromInt(us));
        }

        pub fn from_ms(ms: u64) Duration {
            return from_us(1000 * ms);
        }

        pub fn to_us(duration: Duration) u64 {
            return @intFromEnum(duration);
        }

        pub fn less_than(self: Duration, other: Duration) bool {
            return self.to_us() < other.to_us();
        }

        pub fn minus(self: Duration, other: Duration) Duration {
            return from_us(self.to_us() - other.to_us());
        }

        pub fn plus(self: Duration, other: Duration) Duration {
            return from_us(self.to_us() + other.to_us());
        }
    };

    ///
    /// The deadline construct is a construct to create optional timeouts.
    ///
    /// NOTE: Deadlines use maximum possible `Absolute` time for
    ///       marking the deadline as "unreachable", as this would mean the device
    ///       would ever reach an uptime of over 500.000 years.
    ///
    pub const Deadline = struct {
        const disabled_sentinel = Absolute.from_us(std.math.maxInt(u64));

        timeout: Absolute,

        /// Create a new deadline with an absolute end point.
        ///
        /// NOTE: `abs` must not point to the absolute maximum time stamp, as this is
        ///       used as a sentinel for "unset" deadlines.
        pub fn init_absolute(abs: ?Absolute) Deadline {
            if (abs) |a|
                std.debug.assert(a != disabled_sentinel);
            return .{ .timeout = abs orelse disabled_sentinel };
        }

        /// Create a new deadline with a certain duration from provided time.
        pub fn init_relative(since: Absolute, dur: ?Duration) Deadline {
            return init_absolute(if (dur) |d|
                make_timeout(since, d)
            else
                null);
        }

        /// Returns `true` if the deadline can be reached.
        pub fn can_be_reached(deadline: Deadline) bool {
            return (deadline.timeout != disabled_sentinel);
        }

        /// Returns `true` if the deadline is reached.
        pub fn is_reached_by(deadline: Deadline, now: Absolute) bool {
            return deadline.can_be_reached() and deadline.timeout.is_reached_by(now);
        }

        /// Checks if the deadline is reached and returns an error if so,
        pub fn check(deadline: Deadline, now: Absolute) error{Timeout}!void {
            if (deadline.is_reached_by(now))
                return error.Timeout;
        }
    };

    pub fn make_timeout(since: Absolute, timeout: Duration) Absolute {
        return @as(Absolute, @enumFromInt(since.to_us() + timeout.to_us()));
    }

    pub fn make_timeout_us(since: Absolute, timeout_us: u64) Absolute {
        return @as(Absolute, @enumFromInt(since.to_us() + timeout_us));
    }
};

pub const DateTime = @import("base/DateTime.zig");

pub const base = struct {
    pub const Datagram_Device = @import("base/Datagram_Device.zig");
    pub const Stream_Device = @import("base/Stream_Device.zig");
    pub const Digital_IO = @import("base/Digital_IO.zig");
    pub const Clock_Device = @import("base/Clock_Device.zig");
};

test {
    _ = display.sh1106;
    _ = display.ssd1306;
    _ = display.st77xx;
    _ = display.HD44780;

    _ = input.keyboard_matrix;
    _ = input.debounced_button;
    _ = input.rotary_encoder;

    _ = sensor.TMP117;
    _ = sensor.ICM_20948;

    _ = @import("stepper/common.zig");
    _ = stepper.A4988;
    _ = stepper.DRV8825;
    _ = stepper.ULN2003;

    _ = IO_expander.pcf8574;

    _ = time;
    _ = DateTime;

    _ = base.Datagram_Device;
    _ = base.Stream_Device;
    _ = base.Digital_IO;
}
