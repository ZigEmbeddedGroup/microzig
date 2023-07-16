const std = @import("std");
const mdf = @import("../framework.zig");

pub const SSD1306 = SSD1306_Generic(mdf.base.DatagramDevice);

pub fn SSD1306_Generic(comptime DatagramDevice: type) type {
    return struct {
        const Self = @This();
        dd: DatagramDevice,

        // TODO(philippwendel) Add doc comments for functions
        // TODO(philippwendel) Find out why using 'inline if' in writeAll(&[_]u8{ command, if(cond) val1 else val2 }); hangs code on atmega328p, since tests work fine
        pub fn init(dev: DatagramDevice) !Self {
            var self = Self{ .dd = dev };

            try self.setDisplay(.off);

            try self.deactivateScroll();
            try self.setSegmentRemap(true); // Flip left/right
            try self.setCOMOuputScanDirection(true); // Flip up/down
            try self.setNormalOrInverseDisplay(.normal);
            try self.setContrast(255);

            try self.chargePumpSetting(true);
            try self.setMultiplexRatio(63); // Default
            try self.setDisplayClockDivideRatioAndOscillatorFrequency(0, 8);
            try self.setPrechargePeriod(0b0001, 0b0001);
            try self.setV_COMH_DeselectLevel(0x4);
            try self.setCOMPinsHardwareConfiguration(0b001); // See page 40 in datasheet

            try self.setDisplayOffset(0);
            try self.setDisplayStartLine(0);
            try self.entireDisplayOn(.resumeToRam);

            try self.setDisplay(.on);

            return self;
        }

        pub fn clearScreen(self: Self, white: bool) !void {
            try self.setMemoryAddressingMode(.horizontal);
            try self.setColumnAddress(0, 127);
            try self.setPageAddress(0, 7);
            for (0..(128 * 8)) |_| {
                try self.dd.connect();
                defer self.dd.disconnect();
                if (white) {
                    try self.dd.write(&[_]u8{ control_data, 0xFF });
                } else {
                    try self.dd.write(&[_]u8{ control_data, 0x00 });
                }
            }
            try self.entireDisplayOn(.resumeToRam);
            try self.setDisplay(.on);
        }

        // Fundamental Commands
        pub fn setContrast(self: Self, contrast: u8) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0x81, contrast });
        }

        pub fn entireDisplayOn(self: Self, mode: DisplayOnMode) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, @intFromEnum(mode) });
        }

        pub fn setNormalOrInverseDisplay(self: Self, mode: NormalOrInverseDisplay) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, @intFromEnum(mode) });
        }

        pub fn setDisplay(self: Self, mode: DisplayMode) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, @intFromEnum(mode) });
        }

        // Scrolling Commands
        pub fn continuousHorizontalScrollSetup(self: Self, direction: HorizontalScrollDirection, start_page: u3, end_page: u3, frame_frequency: u3) !void {
            if (end_page < start_page) return PageError.EndPageIsSmallerThanStartPage;

            try self.dd.connect();
            defer self.dd.disconnect();
            try self.dd.write(&[_]u8{
                command,
                @intFromEnum(direction),
                0x00, // Dummy byte
                @as(u8, start_page),
                @as(u8, frame_frequency),
                @as(u8, end_page),
                0x00, // Dummy byte
                0xFF, // Dummy byte
            });
        }

        pub fn continuousVerticalAndHorizontalScrollSetup(self: Self, direction: VerticalAndHorizontalScrollDirection, start_page: u3, end_page: u3, frame_frequency: u3, vertical_scrolling_offset: u6) !void {
            try self.dd.connect();
            defer self.dd.disconnect();
            try self.dd.write(&[_]u8{
                command,
                @intFromEnum(direction),
                0x00, // Dummy byte
                @as(u8, start_page),
                @as(u8, frame_frequency),
                @as(u8, end_page),
                @as(u8, vertical_scrolling_offset),
            });
        }

        pub fn deactivateScroll(self: Self) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0x2E });
        }

        pub fn activateScroll(self: Self) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0x2F });
        }

        pub fn setVerticalScrollArea(self: Self, start_row: u6, num_of_rows: u7) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xA3, @as(u8, start_row), @as(u8, num_of_rows) });
        }

        // Addressing Setting Commands
        pub fn setColumnStartAddressForPageAddressingMode(self: Self, column: Column, address: u4) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, (@as(u8, @intFromEnum(column)) << 4) | @as(u8, address) });
        }

        pub fn setMemoryAddressingMode(self: Self, mode: MemoryAddressingMode) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0x20, @as(u8, @intFromEnum(mode)) });
        }

        pub fn setColumnAddress(self: Self, start: u7, end: u7) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0x21, @as(u8, start), @as(u8, end) });
        }

        pub fn setPageAddress(self: Self, start: u3, end: u3) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0x22, @as(u8, start), @as(u8, end) });
        }

        pub fn setPageStartAddress(self: Self, address: u3) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xB0 | @as(u8, address) });
        }

        // Hardware Configuration Commands
        pub fn setDisplayStartLine(self: Self, line: u6) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0x40 | @as(u8, line) });
        }

        // false: column address 0 is mapped to SEG0
        // true: column address 127 is mapped to SEG0
        pub fn setSegmentRemap(self: Self, remap: bool) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            if (remap) {
                try self.dd.write(&[_]u8{ command, 0xA1 });
            } else {
                try self.dd.write(&[_]u8{ command, 0xA0 });
            }
        }

        pub fn setMultiplexRatio(self: Self, ratio: u6) !void {
            if (ratio <= 14) return InputError.InvalidEntry;

            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xA8, @as(u8, ratio) });
        }

        /// false: normal (COM0 to COMn)
        /// true: remapped
        pub fn setCOMOuputScanDirection(self: Self, remap: bool) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            if (remap) {
                try self.dd.write(&[_]u8{ command, 0xC8 });
            } else {
                try self.dd.write(&[_]u8{ command, 0xC0 });
            }
        }

        pub fn setDisplayOffset(self: Self, vertical_shift: u6) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xD3, @as(u8, vertical_shift) });
        }

        // TODO(philippwendel) Make config to enum
        pub fn setCOMPinsHardwareConfiguration(self: Self, config: u2) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xDA, @as(u8, config) << 4 | 0x02 });
        }

        // Timing & Driving Scheme Setting Commands
        // TODO(philippwendel) Split in two funktions
        pub fn setDisplayClockDivideRatioAndOscillatorFrequency(self: Self, divide_ratio: u4, freq: u4) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xD5, (@as(u8, freq) << 4) | @as(u8, divide_ratio) });
        }

        pub fn setPrechargePeriod(self: Self, phase1: u4, phase2: u4) !void {
            if (phase1 == 0 or phase2 == 0) return InputError.InvalidEntry;

            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xD9, @as(u8, phase2) << 4 | @as(u8, phase1) });
        }

        // TODO(philippwendel) Make level to enum
        pub fn setV_COMH_DeselectLevel(self: Self, level: u3) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xDB, @as(u8, level) << 4 });
        }

        pub fn nop(self: Self) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            try self.dd.write(&[_]u8{ command, 0xE3 });
        }

        // Charge Pump Commands
        pub fn chargePumpSetting(self: Self, enable: bool) !void {
            try self.dd.connect();
            defer self.dd.disconnect();

            if (enable) {
                try self.dd.write(&[_]u8{ command, 0x8D, 0x14 });
            } else {
                try self.dd.write(&[_]u8{ command, 0x8D, 0x10 });
            }
        }
    };
}

const command = 0x00;
const control_data = 0x40;

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
        var td = TestDevice.initRecevierOnly();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, 0x81, contrast };

        // Act
        const driver = try SSD1306.init(td.datagramDevice());
        try driver.setContrast(contrast);

        // Assert
        try td.expectSent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "entireDisplayOn" {
    // Arrange
    for ([_]u8{ 0xA4, 0xA5 }, [_]DisplayOnMode{ DisplayOnMode.resumeToRam, DisplayOnMode.ignoreRam }) |data, mode| {
        var td = TestDevice.initRecevierOnly();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagramDevice());
        try driver.entireDisplayOn(mode);
        // Assert
        try td.expectSent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setNormalOrInverseDisplay" {
    // Arrange
    for ([_]u8{ 0xA6, 0xA7 }, [_]NormalOrInverseDisplay{ NormalOrInverseDisplay.normal, NormalOrInverseDisplay.inverse }) |data, mode| {
        var td = TestDevice.initRecevierOnly();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagramDevice());
        try driver.setNormalOrInverseDisplay(mode);
        // Assert
        try td.expectSent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setDisplay" {
    // Arrange
    for ([_]u8{ 0xAF, 0xAE }, [_]DisplayMode{ DisplayMode.on, DisplayMode.off }) |data, mode| {
        var td = TestDevice.initRecevierOnly();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagramDevice());
        try driver.setDisplay(mode);
        // Assert
        try td.expectSent(&recorded_init_sequence ++ .{expected_data});
    }
}

// Scrolling Commands
// TODO(philippwendel) Test more values and error
test "continuousHorizontalScrollSetup" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.continuousHorizontalScrollSetup(.right, 0, 0, 0);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "continuousVerticalAndHorizontalScrollSetup" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x29, 0x00, 0x01, 0x3, 0x2, 0x4 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.continuousVerticalAndHorizontalScrollSetup(.right, 1, 2, 3, 4);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "deactivateScroll" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x2E };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.deactivateScroll();
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "activateScroll" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x2F };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.activateScroll();
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "setVerticalScrollArea" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xA3, 0x00, 0x0F };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setVerticalScrollArea(0, 15);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

// Addressing Setting Commands
test "setColumnStartAddressForPageAddressingMode" {
    // Arrange
    for ([_]Column{ Column.lower, Column.higher }, [_]u8{ 0x0F, 0x1F }) |column, data| {
        var td = TestDevice.initRecevierOnly();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, data };
        // Act
        const driver = try SSD1306.init(td.datagramDevice());
        try driver.setColumnStartAddressForPageAddressingMode(column, 0xF);
        // Assert
        try td.expectSent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setMemoryAddressingMode" {
    // Arrange
    for ([_]MemoryAddressingMode{ .horizontal, .vertical, .page }) |mode| {
        var td = TestDevice.initRecevierOnly();
        defer td.deinit();

        const expected_data = &[_]u8{ 0x00, 0x20, @as(u8, @intFromEnum(mode)) };
        // Act
        const driver = try SSD1306.init(td.datagramDevice());
        try driver.setMemoryAddressingMode(mode);
        // Assert
        try td.expectSent(&recorded_init_sequence ++ .{expected_data});
    }
}

test "setColumnAddress" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x21, 0, 127 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setColumnAddress(0, 127);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "setPageAddress" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0x22, 0, 7 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setPageAddress(0, 7);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "setPageStartAddress" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xB7 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setPageStartAddress(7);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

// Hardware Configuration Commands
test "setDisplayStartLine" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0b0110_0000 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setDisplayStartLine(32);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "setSegmentRemap" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_][]const u8{ &.{ 0x00, 0xA0 }, &.{ 0x00, 0xA1 } };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setSegmentRemap(false);
    try driver.setSegmentRemap(true);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ expected_data);
}

test "setMultiplexRatio" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xA8, 15 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setMultiplexRatio(15);
    const err = driver.setMultiplexRatio(0);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
    try std.testing.expectEqual(err, InputError.InvalidEntry);
}

test "setCOMOuputScanDirection" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_][]const u8{ &.{ 0x00, 0xC0 }, &.{ 0x00, 0xC8 } };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setCOMOuputScanDirection(false);
    try driver.setCOMOuputScanDirection(true);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ expected_data);
}

test "setDisplayOffset" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xD3, 17 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setDisplayOffset(17);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "setCOMPinsHardwareConfiguration" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xDA, 0b0011_0010 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setCOMPinsHardwareConfiguration(0b11);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

// Timing & Driving Scheme Setting Commands
test "setDisplayClockDivideRatioAndOscillatorFrequency" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xD5, 0x00 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setDisplayClockDivideRatioAndOscillatorFrequency(0, 0);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "setPrechargePeriod" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xD9, 0b0001_0001 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setPrechargePeriod(1, 1);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "setV_COMH_DeselectLevel" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xDB, 0b0011_0000 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.setV_COMH_DeselectLevel(0b011);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

test "nop" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_]u8{ 0x00, 0xE3 };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.nop();
    // Assert
    try td.expectSent(&recorded_init_sequence ++ .{expected_data});
}

// Charge Pump Commands
test "chargePumpSetting" {
    // Arrange
    var td = TestDevice.initRecevierOnly();
    defer td.deinit();

    const expected_data = &[_][]const u8{ &.{ 0x00, 0x8D, 0x14 }, &.{ 0x00, 0x8D, 0x10 } };
    // Act
    const driver = try SSD1306.init(td.datagramDevice());
    try driver.chargePumpSetting(true);
    try driver.chargePumpSetting(false);
    // Assert
    try td.expectSent(&recorded_init_sequence ++ expected_data);
}

// References:
// [1] https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf
