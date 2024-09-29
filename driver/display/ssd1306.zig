//!
//! Generic driver for the SSD1306 display controller.
//!
//! This controller is usually found in small OLED displays.
//!
//! Datasheet:
//! https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf
//!
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const SSD1306 = SSD1306_Generic(mdf.base.DatagramDevice);

pub fn SSD1306_Generic(comptime DatagramDevice: type) type {
    return struct {
        const buffer_size = 16;

        const white_line: [128]u8 = .{0xFF} ** 128;
        const black_line: [128]u8 = .{0x00} ** 128;

        const Self = @This();
        dd: DatagramDevice,

        // TODO(philippwendel) Add doc comments for functions
        // TODO(philippwendel) Find out why using 'inline if' in writeAll(&[_]u8{ControlByte.command, if(cond) val1 else val2 }); hangs code on atmega328p, since tests work fine
        pub fn init(dev: DatagramDevice) !Self {
            var self = Self{ .dd = dev };

            try self.set_display(.off);

            try self.deactivate_scroll();
            try self.set_segment_remap(true); // Flip left/right
            try self.set_com_ouput_scan_direction(true); // Flip up/down
            try self.set_normal_or_inverse_display(.normal);
            try self.set_contrast(255);

            try self.charge_pump_setting(true);
            try self.set_multiplex_ratio(63); // Default
            try self.set_display_clock_divide_ratio_and_oscillator_frequency(0, 8);
            try self.set_precharge_period(0b0001, 0b0001);
            try self.set_v_comh_deselect_level(0x4);
            try self.set_com_pins_hardware_configuration(0b001); // See page 40 in datasheet

            try self.set_display_offset(0);
            try self.set_display_start_line(0);
            try self.entire_display_on(.resumeToRam);

            try self.set_display(.on);

            return self;
        }

        pub fn write_gdram(self: Self, data: []const u8) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            for (data) |byte| {
                try self.dd.write(&.{ ControlByte.data_byte, byte });
            }

            // var buffer: [buffer_size]u8 = undefined;
            // buffer[0x00] = ControlByte.data_stream;

            // var offset: usize = 0;

            // while (offset < data.len) {
            //     const chunk_size = @min(buffer.len, data.len - offset);

            //     const chunk = data[offset..][0..chunk_size];

            //     @memcpy(buffer[1 .. chunk_size + 1], chunk);

            //     try self.dd.write(&[_]u8{buffer[0 .. chunk_size + 1]});

            //     offset += chunk_size;
            // }
        }

        pub fn clear_screen(self: Self, white: bool) !void {
            try self.set_memory_addressing_mode(.horizontal);
            try self.set_column_address(0, 127);
            try self.set_page_address(0, 7);
            {
                try self.dd.connect();
                defer self.dd.disconnect();

                const color: u8 = if (white) 0xFF else 0x00;

                for (0..128 * 8) |_| {
                    try self.dd.write(&.{ ControlByte.data_byte, color });
                }
            }
            try self.entire_display_on(.resumeToRam);
            try self.set_display(.on);
        }

        // Fundamental Commands
        pub fn set_contrast(self: Self, contrast: u8) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0x81, contrast });
        }

        pub fn entire_display_on(self: Self, mode: DisplayOnMode) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, @intFromEnum(mode) });
        }

        pub fn set_normal_or_inverse_display(self: Self, mode: NormalOrInverseDisplay) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, @intFromEnum(mode) });
        }

        pub fn set_display(self: Self, mode: DisplayMode) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, @intFromEnum(mode) });
        }

        // Scrolling Commands
        pub fn continuous_horizontal_scroll_setup(self: Self, direction: HorizontalScrollDirection, start_page: u3, end_page: u3, frame_frequency: u3) !void {
            if (end_page < start_page) return PageError.EndPageIsSmallerThanStartPage;

            try self.dd.connect();
            defer self.dd.disconnect();
            try self.dd.write(&[_]u8{
                ControlByte.command,
                @intFromEnum(direction),
                0x00, // Dummy byte
                @as(u8, start_page),
                @as(u8, frame_frequency),
                @as(u8, end_page),
                0x00, // Dummy byte
                0xFF, // Dummy byte
            });
        }

        pub fn continuous_vertical_and_horizontal_scroll_setup(self: Self, direction: VerticalAndHorizontalScrollDirection, start_page: u3, end_page: u3, frame_frequency: u3, vertical_scrolling_offset: u6) !void {
            try self.dd.connect();
            defer self.dd.disconnect();
            try self.dd.write(&[_]u8{
                ControlByte.command,
                @intFromEnum(direction),
                0x00, // Dummy byte
                @as(u8, start_page),
                @as(u8, frame_frequency),
                @as(u8, end_page),
                @as(u8, vertical_scrolling_offset),
            });
        }

        pub fn deactivate_scroll(self: Self) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0x2E });
        }

        pub fn activate_scroll(self: Self) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0x2F });
        }

        pub fn set_vertical_scroll_area(self: Self, start_row: u6, num_of_rows: u7) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xA3, @as(u8, start_row), @as(u8, num_of_rows) });
        }

        // Addressing Setting Commands
        pub fn set_column_start_address_for_page_addressing_mode(self: Self, column: Column, address: u4) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, (@as(u8, @intFromEnum(column)) << 4) | @as(u8, address) });
        }

        pub fn set_memory_addressing_mode(self: Self, mode: MemoryAddressingMode) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0x20, @as(u8, @intFromEnum(mode)) });
        }

        pub fn set_column_address(self: Self, start: u7, end: u7) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0x21, @as(u8, start), @as(u8, end) });
        }

        pub fn set_page_address(self: Self, start: u3, end: u3) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0x22, @as(u8, start), @as(u8, end) });
        }

        pub fn set_page_start_address(self: Self, address: u3) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xB0 | @as(u8, address) });
        }

        // Hardware Configuration Commands
        pub fn set_display_start_line(self: Self, line: u6) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0x40 | @as(u8, line) });
        }

        // false: column address 0 is mapped to SEG0
        // true: column address 127 is mapped to SEG0
        pub fn set_segment_remap(self: Self, remap: bool) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            if (remap) {
                try self.dd.write(&[_]u8{ ControlByte.command, 0xA1 });
            } else {
                try self.dd.write(&[_]u8{ ControlByte.command, 0xA0 });
            }
        }

        pub fn set_multiplex_ratio(self: Self, ratio: u6) !void {
            if (ratio <= 14) return InputError.InvalidEntry;

            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xA8, @as(u8, ratio) });
        }

        /// false: normal (COM0 to COMn)
        /// true: remapped
        pub fn set_com_ouput_scan_direction(self: Self, remap: bool) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            if (remap) {
                try self.dd.write(&[_]u8{ ControlByte.command, 0xC8 });
            } else {
                try self.dd.write(&[_]u8{ ControlByte.command, 0xC0 });
            }
        }

        pub fn set_display_offset(self: Self, vertical_shift: u6) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xD3, @as(u8, vertical_shift) });
        }

        // TODO(philippwendel) Make config to enum
        pub fn set_com_pins_hardware_configuration(self: Self, config: u2) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xDA, @as(u8, config) << 4 | 0x02 });
        }

        // Timing & Driving Scheme Setting Commands
        // TODO(philippwendel) Split in two funktions
        pub fn set_display_clock_divide_ratio_and_oscillator_frequency(self: Self, divide_ratio: u4, freq: u4) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xD5, (@as(u8, freq) << 4) | @as(u8, divide_ratio) });
        }

        pub fn set_precharge_period(self: Self, phase1: u4, phase2: u4) !void {
            if (phase1 == 0 or phase2 == 0) return InputError.InvalidEntry;

            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xD9, @as(u8, phase2) << 4 | @as(u8, phase1) });
        }

        // TODO(philippwendel) Make level to enum
        pub fn set_v_comh_deselect_level(self: Self, level: u3) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xDB, @as(u8, level) << 4 });
        }

        pub fn nop(self: Self) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ ControlByte.command, 0xE3 });
        }

        // Charge Pump Commands
        pub fn charge_pump_setting(self: Self, enable: bool) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            if (enable) {
                try self.dd.write(&[_]u8{ ControlByte.command, 0x8D, 0x14 });
            } else {
                try self.dd.write(&[_]u8{ ControlByte.command, 0x8D, 0x10 });
            }
        }
    };
}

const ControlByte = packed struct(u8) {
    zero: u6 = 0,
    mode: enum(u1) { command = 0, data = 1 },
    continuous: bool,

    const command: u8 = @bitCast(ControlByte{
        .mode = .command,
        .continuous = false,
    });

    const data_byte: u8 = @bitCast(ControlByte{
        .mode = .data,
        .continuous = false,
    });

    const data_stream: u8 = @bitCast(ControlByte{
        .mode = .data,
        .continuous = true,
    });
};

comptime {
    std.debug.assert(ControlByte.command == 0x00);
    std.debug.assert(ControlByte.data_byte == 0x40);
    std.debug.assert(ControlByte.data_stream == 0xC0);
}

// Fundamental Commands
const DisplayOnMode = enum(u8) { resumeToRam = 0xA4, ignoreRam = 0xA5 };
const NormalOrInverseDisplay = enum(u8) { normal = 0xA6, inverse = 0xA7 };
const DisplayMode = enum(u8) { off = 0xAE, on = 0xAF };

// Scrolling Commands
const HorizontalScrollDirection = enum(u8) { right = 0x26, left = 0x27 };
const VerticalAndHorizontalScrollDirection = enum(u8) { right = 0x29, left = 0x2A };
const PageError = error{EndPageIsSmallerThanStartPage};

// Addressing Setting Commands
const Column = enum(u1) { lower = 0, higher = 1 };
const MemoryAddressingMode = enum(u2) { horizontal = 0b00, vertical = 0b01, page = 0b10 };

// Hardware Configuration Commands
const InputError = error{InvalidEntry};

// Tests

const TestDevice = mdf.base.DatagramDevice.TestDevice;

// This is the command sequence created by SSD1306.init()
// to set up the display.
const recorded_init_sequence = [_][]const u8{
    &.{ 0x00, 0xAE },
    &.{ 0x00, 0x2E },
    &.{ 0x00, 0xA1 },
    &.{ 0x00, 0xC8 },
    &.{ 0x00, 0xA6 },
    &.{ 0x00, 0x81, 0xFF },
    &.{ 0x00, 0x8D, 0x14 },
    &.{ 0x00, 0xA8, 0x3F },
    &.{ 0x00, 0xD5, 0x80 },
    &.{ 0x00, 0xD9, 0x11 },
    &.{ 0x00, 0xDB, 0x40 },
    &.{ 0x00, 0xDA, 0x12 },
    &.{ 0x00, 0xD3, 0x00 },
    &.{ 0x00, 0x40 },
    &.{ 0x00, 0xA4 },
    &.{ 0x00, 0xAF },
};

// Fundamental Commands
test "setContrast" {
    // Arrange
    for ([_]u8{ 0, 128, 255 }) |contrast| {
        var td = TestDevice.init_receiver_only();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, 0x81, contrast };

        // Act
        const driver = try SSD1306.init(td.datagram_device());
        try driver.set_contrast(contrast);

        // Assert
        try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "entireDisplayOn" {
    // Arrange
    for ([_]u8{ 0xA4, 0xA5 }, [_]DisplayOnMode{ DisplayOnMode.resumeToRam, DisplayOnMode.ignoreRam }) |data, mode| {
        var td = TestDevice.init_receiver_only();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagram_device());
        try driver.entire_display_on(mode);
        // Assert
        try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setNormalOrInverseDisplay" {
    // Arrange
    for ([_]u8{ 0xA6, 0xA7 }, [_]NormalOrInverseDisplay{ NormalOrInverseDisplay.normal, NormalOrInverseDisplay.inverse }) |data, mode| {
        var td = TestDevice.init_receiver_only();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagram_device());
        try driver.set_normal_or_inverse_display(mode);
        // Assert
        try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setDisplay" {
    // Arrange
    for ([_]u8{ 0xAF, 0xAE }, [_]DisplayMode{ DisplayMode.on, DisplayMode.off }) |data, mode| {
        var td = TestDevice.init_receiver_only();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagram_device());
        try driver.set_display(mode);
        // Assert
        try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
    }
}

// Scrolling Commands
// TODO(philippwendel) Test more values and error
test "continuousHorizontalScrollSetup" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.continuous_horizontal_scroll_setup(.right, 0, 0, 0);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "continuousVerticalAndHorizontalScrollSetup" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x29, 0x00, 0x01, 0x3, 0x2, 0x4 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.continuous_vertical_and_horizontal_scroll_setup(.right, 1, 2, 3, 4);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "deactivateScroll" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x2E };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.deactivate_scroll();
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "activateScroll" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x2F };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.activate_scroll();
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "setVerticalScrollArea" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xA3, 0x00, 0x0F };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_vertical_scroll_area(0, 15);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

// Addressing Setting Commands
test "setColumnStartAddressForPageAddressingMode" {
    // Arrange
    for ([_]Column{ Column.lower, Column.higher }, [_]u8{ 0x0F, 0x1F }) |column, data| {
        var td = TestDevice.init_receiver_only();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagram_device());
        try driver.set_column_start_address_for_page_addressing_mode(column, 0xF);
        // Assert
        try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setMemoryAddressingMode" {
    // Arrange
    for ([_]MemoryAddressingMode{ .horizontal, .vertical, .page }) |mode| {
        var td = TestDevice.init_receiver_only();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, 0x20, @as(u8, @intFromEnum(mode)) };
        // Act
        const driver = try SSD1306.init(td.datagram_device());
        try driver.set_memory_addressing_mode(mode);
        // Assert
        try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setColumnAddress" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x21, 0, 127 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_column_address(0, 127);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "setPageAddress" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x22, 0, 7 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_page_address(0, 7);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "setPageStartAddress" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xB7 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_page_start_address(7);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

// Hardware Configuration Commands
test "setDisplayStartLine" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0b0110_0000 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_display_start_line(32);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "setSegmentRemap" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_][]const u8{ &.{ 0x00, 0xA0 }, &.{ 0x00, 0xA1 } };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_segment_remap(false);
    try driver.set_segment_remap(true);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ expected_data);
}

test "setMultiplexRatio" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xA8, 15 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_multiplex_ratio(15);
    const err = driver.set_multiplex_ratio(0);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
    try std.testing.expectEqual(err, InputError.InvalidEntry);
}

test "setCOMOuputScanDirection" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_][]const u8{ &.{ 0x00, 0xC0 }, &.{ 0x00, 0xC8 } };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_com_ouput_scan_direction(false);
    try driver.set_com_ouput_scan_direction(true);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ expected_data);
}

test "setDisplayOffset" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xD3, 17 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_display_offset(17);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "setCOMPinsHardwareConfiguration" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xDA, 0b0011_0010 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_com_pins_hardware_configuration(0b11);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

// Timing & Driving Scheme Setting Commands
test "setDisplayClockDivideRatioAndOscillatorFrequency" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xD5, 0x00 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_display_clock_divide_ratio_and_oscillator_frequency(0, 0);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "setPrechargePeriod" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xD9, 0b0001_0001 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_precharge_period(1, 1);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "setV_COMH_DeselectLevel" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xDB, 0b0011_0000 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.set_v_comh_deselect_level(0b011);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

test "nop" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xE3 };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.nop();
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
}

// Charge Pump Commands
test "chargePumpSetting" {
    // Arrange
    var td = TestDevice.init_receiver_only();
    defer td.deinit();

    const expected_data = &[_][]const u8{ &.{ 0x00, 0x8D, 0x14 }, &.{ 0x00, 0x8D, 0x10 } };
    // Act
    const driver = try SSD1306.init(td.datagram_device());
    try driver.charge_pump_setting(true);
    try driver.charge_pump_setting(false);
    // Assert
    try td.expect_sent(&recorded_init_sequence ++ expected_data);
}

// References:
// [1] https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf
