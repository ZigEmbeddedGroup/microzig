//! Sharp Memory LCD (LS0xx family) Display Driver
//!
//! This driver supports Sharp Memory LCDs and compatible displays such as:
//! - nice!view (160x68, no VCOM)
//! - Sharp LS011B7DH03 (128x128, software VCOM)
//! - Sharp LS013B7DH03 (128x128, software VCOM)
//! - Sharp LS027B7DH01 (400x240, software VCOM)
//!
//! Protocol: 3-wire SPI with LSB-first bit order, CS active-high
//!
//! Key Features:
//! - Line-major framebuffer matching display RAM organization
//! - LSB-first bit ordering (bit 0 = leftmost pixel)
//! - Compile-time optional VCOM toggling (zero overhead when disabled)
//! - Efficient vectored I/O for line writes
//! - Support for partial (line-by-line) and full-screen updates
//!
//! Example usage:
//! ```zig
//! const Display = Sharp_Memory_LCD(.{
//!     .width = 160,
//!     .height = 68,
//!     .vcom_mode = .none,  // nice!view doesn't need VCOM
//! });
//!
//! var display = try Display.init(spi_datagram_device, disp_enable_pin);
//! try display.clear_screen();
//!
//! var fb = Display.Framebuffer.init(.white);
//! fb.set_pixel(10, 10, .black);
//! try display.write_full_display(&fb);
//! ```

const std = @import("std");
const mdf = @import("../framework.zig");

/// VCOM (Voltage Compensation) mode for Sharp Memory LCDs
/// WARNING: This can be required for actual sharp LCD panels to avoid damaging the LCD.
pub const VCOM_Mode = enum {
    /// No VCOM toggling needed (nice!view and newer displays)
    none,
    /// Software VCOM toggling (requires periodic toggle_vcom() calls, at least once per second)
    software,
};

/// Configuration for Sharp Memory LCD driver
pub const Config = struct {
    /// Display width in pixels (must be multiple of 8)
    width: comptime_int,
    /// Display height in pixels
    height: comptime_int,
    /// VCOM mode (none for nice!view, software for older displays)
    vcom_mode: VCOM_Mode = .none,
    /// Datagram device type (typically SPI_Datagram_Device)
    Datagram_Device: type = mdf.base.Datagram_Device,
    /// Optional digital I/O type for DISP enable pin
    Digital_IO: ?type = null,
};

// TODO: Use an enum
/// Sharp Memory LCD command bytes
const Cmd = enum(u8) {
    Write = 0x01, // Write line data
    Clear = 0x04, // Clear entire screen
    VCOM = 0x02, // VCOM bit (OR'd with command when toggling)
};

/// Pixel color for Sharp Memory LCDs
pub const Color = enum(u1) {
    white = 0, // Clear/off
    black = 1, // Dark/on

    pub fn invert(self: Color) Color {
        return switch (self) {
            .white => .black,
            .black => .white,
        };
    }
};

/// Create a Sharp Memory LCD driver instance
pub fn Sharp_Memory_LCD(comptime config: Config) type {
    // Validate config at compile time
    if (config.width % 8 != 0) {
        @compileError("LCD width must be a multiple of 8");
    }
    if (config.width == 0 or config.height == 0) {
        @compileError("LCD width and height must be non-zero");
    }

    return struct {
        const Self = @This();

        /// Datagram device for SPI communication
        dd: config.Datagram_Device,
        /// Optional display enable pin
        disp_pin: if (config.Digital_IO) |T| T else void,
        /// VCOM state (compile-time conditional, zero cost when disabled)
        vcom_state: if (config.vcom_mode == .software) bool else void,
        /// Bytes per display line
        pub const bytes_per_line = config.width / 8;
        /// Total display size in bytes
        pub const display_size_bytes = bytes_per_line * config.height;
        /// Framebuffer type for this display
        pub const Framebuffer = Framebuffer_Type(config.width, config.height);

        /// Initialize the Sharp Memory LCD driver
        pub fn init(
            dd: config.Datagram_Device,
            disp_pin: if (config.Digital_IO) |T| T else void,
        ) !Self {
            var self = Self{
                .dd = dd,
                .disp_pin = disp_pin,
                .vcom_state = if (config.vcom_mode == .software) false else {},
            };

            // Enable display if Digital_IO is provided
            if (comptime config.Digital_IO != null) {
                try self.disp_pin.write(.high);
            }

            return self;
        }

        /// Get command byte with optional VCOM bit (compile-time optimized)
        fn get_command_byte(self: *Self, base_cmd: Cmd) u8 {
            if (comptime config.vcom_mode == .software) {
                // Toggle VCOM state
                self.vcom_state = !self.vcom_state;
                return @intFromEnum(base_cmd) | if (self.vcom_state) @intFromEnum(Cmd.VCOM) else 0;
            }
            // No VCOM overhead for displays that don't need it
            return @intFromEnum(base_cmd);
        }

        /// Clear the entire display to white
        pub fn clear_screen(self: *Self) !void {
            const cmd = self.get_command_byte(Cmd.Clear);

            try self.dd.connect();
            defer self.dd.disconnect();

            // Clear command: [Cmd.Clear | VCOM][0x00]
            try self.dd.write(&.{ cmd, 0x00 });
        }

        /// Write a single line to the display
        /// line_num: 0-based line number (will be converted to 1-based for Sharp protocol)
        /// data: pixel data for the line (must be bytes_per_line bytes)
        pub fn write_line(self: *Self, line_num: usize, data: *const [bytes_per_line]u8) !void {
            if (line_num >= config.height) {
                return error.LineOutOfBounds;
            }
            if (data.len != bytes_per_line) {
                return error.InvalidLineLength;
            }

            const cmd = self.get_command_byte(Cmd.Write);
            const line_byte: u8 = @intCast(line_num + 1); // Convert to 1-based addressing

            try self.dd.connect();
            defer self.dd.disconnect();

            // Write command: [Cmd.Write | VCOM][line_num][pixel_data...][dummy_byte]
            // Use vectored I/O for efficiency (single CS assertion)
            try self.dd.writev(&.{
                &.{cmd},
                &.{line_byte},
                data,
                &.{0x00}, // Trailing dummy byte
            });
        }

        /// Write multiple consecutive lines to the display
        /// start_line: 0-based starting line number
        /// data: pixel data for all lines
        ///
        /// Following Zephyr ls0xx driver protocol:
        /// All lines are written in a SINGLE CS transaction:
        /// [CS Low] [CMD] [line1_addr][line1_data][dummy] [line2_addr][line2_data][dummy] ... [final_dummy] [CS High]
        pub fn write_lines(self: *Self, start_line: usize, data: []const u8) !void {
            if (data.len % bytes_per_line != 0) {
                return error.InvalidDataLength;
            }

            const num_lines = data.len / bytes_per_line;
            if (start_line + num_lines > config.height) {
                return error.LineOutOfBounds;
            }

            const cmd = self.get_command_byte(Cmd.Write);

            // Single CS transaction for all lines (matches Zephyr driver)
            try self.dd.connect();
            defer self.dd.disconnect();

            // Write command byte first
            try self.dd.write(&.{cmd});

            // Write each line: [line_addr][line_data][dummy_byte]
            for (0..num_lines) |i| {
                const line_num = start_line + i;
                const line_byte: u8 = @intCast(line_num + 1); // 1-based addressing
                const line_start = i * bytes_per_line;
                const line_end = line_start + bytes_per_line;
                const line_data = data[line_start..line_end];

                // Write: [line_address][pixel_data...][dummy_byte]
                try self.dd.writev(&.{
                    &.{line_byte},
                    line_data,
                    &.{0x00}, // Trailing dummy byte per line
                });
            }

            // Write final trailing dummy byte (per Sharp protocol)
            try self.dd.write(&.{0x00});
        }

        /// Write the entire framebuffer to the display
        pub fn write_full_display(self: *Self, fb: *const Framebuffer) !void {
            try self.write_lines(0, &fb.pixel_data);
        }

        /// Toggle VCOM bit (required for software VCOM mode, no-op otherwise)
        /// For displays with software VCOM, this must be called at least once per second
        /// to prevent DC buildup on the display.
        pub fn toggle_vcom(self: *Self) !void {
            if (comptime config.vcom_mode == .software) {
                // Send a no-op write command just to toggle VCOM
                const cmd = self.get_command_byte(Cmd.Write);

                try self.dd.connect();
                defer self.dd.disconnect();

                try self.dd.write(&.{ cmd, 0x00 });
            }
            // No-op for displays that don't need VCOM
        }
    };
}

/// Generate a framebuffer type for the specified dimensions
fn Framebuffer_Type(comptime width: comptime_int, comptime height: comptime_int) type {
    return struct {
        const Self = @This();

        /// Bytes per line
        pub const bytes_per_line = width / 8;

        /// Total framebuffer size
        pub const size_bytes = bytes_per_line * height;

        /// Pixel data in line-major order (matches Sharp display RAM organization)
        /// Layout: [Line 0: bytes_per_line bytes][Line 1: bytes_per_line bytes]...
        /// Within each byte: LSB-first (bit 0 = leftmost pixel)
        pixel_data: [size_bytes]u8,

        /// Initialize framebuffer with a fill color
        pub fn init(fill_color: Color) Self {
            var self = Self{
                .pixel_data = undefined,
            };
            self.clear(fill_color);
            return self;
        }

        /// Clear framebuffer to a single color
        pub fn clear(self: *Self, color: Color) void {
            const fill_byte: u8 = switch (color) {
                .white => 0x00,
                .black => 0xFF,
            };
            @memset(&self.pixel_data, fill_byte);
        }

        /// Set a pixel at (x, y) to the specified color
        /// Uses LSB-first bit ordering: bit 0 = leftmost pixel
        pub fn set_pixel(self: *Self, x: usize, y: usize, color: Color) void {
            if (x >= width or y >= height) {
                return; // Silently ignore out-of-bounds pixels
            }

            const byte_offset = (y * bytes_per_line) + (x / 8);
            const bit_offset: u3 = @truncate(x % 8);
            const mask: u8 = @as(u8, 1) << bit_offset; // LSB-first

            switch (color) {
                .white => self.pixel_data[byte_offset] &= ~mask,
                .black => self.pixel_data[byte_offset] |= mask,
            }
        }

        /// Get the color of a pixel at (x, y)
        pub fn get_pixel(self: *const Self, x: usize, y: usize) Color {
            if (x >= width or y >= height) {
                return .white; // Default for out-of-bounds
            }

            const byte_offset = (y * bytes_per_line) + (x / 8);
            const bit_offset: u3 = @truncate(x % 8);
            const mask: u8 = @as(u8, 1) << bit_offset; // LSB-first

            return if ((self.pixel_data[byte_offset] & mask) != 0) .black else .white;
        }

        /// Get a slice of pixel data for a specific line
        pub fn get_line(self: *const Self, line_num: usize) []const u8 {
            if (line_num >= height) {
                return &.{}; // Return empty slice for out-of-bounds
            }

            const start = line_num * bytes_per_line;
            const end = start + bytes_per_line;
            return self.pixel_data[start..end];
        }

        /// Fill a rectangular region with a color
        pub fn fill_rect(self: *Self, x0: usize, y0: usize, w: usize, h: usize, color: Color) void {
            for (0..h) |dy| {
                const y = y0 + dy;
                if (y >= height) break;

                for (0..w) |dx| {
                    const x = x0 + dx;
                    if (x >= width) break;

                    self.set_pixel(x, y, color);
                }
            }
        }

        /// Draw a horizontal line
        pub fn draw_hline(self: *Self, x0: usize, y: usize, len: usize, color: Color) void {
            if (y >= height) return;

            for (0..len) |dx| {
                const x = x0 + dx;
                if (x >= width) break;
                self.set_pixel(x, y, color);
            }
        }

        /// Draw a vertical line
        pub fn draw_vline(self: *Self, x: usize, y0: usize, len: usize, color: Color) void {
            if (x >= width) return;

            for (0..len) |dy| {
                const y = y0 + dy;
                if (y >= height) break;
                self.set_pixel(x, y, color);
            }
        }
    };
}

// Tests for framebuffer pixel ordering
test "framebuffer LSB-first pixel ordering" {
    const Fb = Framebuffer_Type(8, 1);
    var fb = Fb.init(.white);

    // Set pixel 0 (leftmost bit) - should set bit 0
    fb.set_pixel(0, 0, .black);
    try std.testing.expectEqual(@as(u8, 0b00000001), fb.pixel_data[0]);

    // Set pixel 7 (rightmost bit) - should set bit 7
    fb.clear(.white);
    fb.set_pixel(7, 0, .black);
    try std.testing.expectEqual(@as(u8, 0b10000000), fb.pixel_data[0]);

    // Set all pixels
    fb.clear(.white);
    for (0..8) |x| {
        fb.set_pixel(x, 0, .black);
    }
    try std.testing.expectEqual(@as(u8, 0xFF), fb.pixel_data[0]);
}

test "framebuffer line-major layout" {
    const Fb = Framebuffer_Type(16, 2);
    var fb = Fb.init(.white);

    // Set pixel at (0, 0) - first byte
    fb.set_pixel(0, 0, .black);
    try std.testing.expectEqual(@as(u8, 0b00000001), fb.pixel_data[0]);
    try std.testing.expectEqual(@as(u8, 0x00), fb.pixel_data[2]); // Second line unchanged

    // Set pixel at (0, 1) - third byte (second line starts at byte 2)
    fb.set_pixel(0, 1, .black);
    try std.testing.expectEqual(@as(u8, 0b00000001), fb.pixel_data[2]);
}

test "framebuffer get_line" {
    const Fb = Framebuffer_Type(16, 2);
    var fb = Fb.init(.white);

    // Fill first line
    for (0..16) |x| {
        fb.set_pixel(x, 0, .black);
    }

    const line0 = fb.get_line(0);
    try std.testing.expectEqual(@as(usize, 2), line0.len);
    try std.testing.expectEqual(@as(u8, 0xFF), line0[0]);
    try std.testing.expectEqual(@as(u8, 0xFF), line0[1]);

    const line1 = fb.get_line(1);
    try std.testing.expectEqual(@as(usize, 2), line1.len);
    try std.testing.expectEqual(@as(u8, 0x00), line1[0]);
    try std.testing.expectEqual(@as(u8, 0x00), line1[1]);
}
