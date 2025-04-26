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

/// SSD1306 driver for I²C based operation.
pub const SSD1306_I2C = SSD1306_Generic(.{
    .mode = .i2c,
});

pub const Driver_Mode = enum {
    /// The driver operates in I²C mode, which requires a 8 bit datagram device.
    /// Each datagram is prefixed with the corresponding command/data byte.
    i2c,

    /// The driver operates in the 3-wire SPI mode, which requires a 9 bit datagram device.
    spi_3wire,

    /// The driver operates in the 4-wire SPI mode, which requires an 8 bit datagram device
    /// as well as a command/data digital i/o.
    spi_4wire,

    /// The driver can be initialized with one of the other options and receives
    /// the mode with initialization.
    dynamic,
};

pub const SSD1306_Options = struct {
    /// Defines the operation of the SSD1306 driver.
    mode: Driver_Mode,

    /// Which datagram device interface should be used.
    Datagram_Device: type = mdf.base.Datagram_Device,

    /// Which digital i/o interface should be used.
    Digital_IO: type = mdf.base.Digital_IO,
};

pub fn init(comptime mode: Driver_Mode, device: anytype, digital_io: anytype) !SSD1306_Generic(.{
    .mode = mode,
    .Datagram_Device = @TypeOf(device),
    .Digital_IO = @TypeOf(digital_io),
}) {
    const Type = SSD1306_Generic(.{
        .mode = mode,
        .Datagram_Device = @TypeOf(device),
        .Digital_IO = @TypeOf(digital_io),
    });

    return switch (mode) {
        .i2c, .spi_3wire => Type.init_without_io(device),
        .spi_4wire => Type.init_with_io(device, digital_io),
        .dynamic => @compileError("unsupported, use SSD1306_Generic directly"),
    };
}

pub fn SSD1306_Generic(comptime options: SSD1306_Options) type {
    switch (options.mode) {
        .i2c, .spi_4wire, .dynamic => {},
        .spi_3wire => @compileError("3-wire SPI operation is not supported yet!"),
    }

    // TODO(philippwendel) Add doc comments for functions
    // TODO(philippwendel) Find out why using 'inline if' in writeAll(&[_]u8{ControlByte.command, if(cond) val1 else val2 }); hangs code on atmega328p, since tests work fine
    return struct {
        const Self = @This();

        const Datagram_Device = options.Datagram_Device;
        const Digital_IO = switch (options.mode) {
            // 4-wire SPI mode uses a dedicated command/data control pin:
            .spi_4wire, .dynamic => options.Digital_IO,

            // The other two modes don't use that, so we use a `void` pin here to save
            // memory:
            .i2c, .spi_3wire => void,
        };

        pub const Driver_Init_Mode = union(enum) {
            i2c: struct {
                device: Datagram_Device,
            },
            spi_3wire: noreturn,
            spi_4wire: struct {
                device: Datagram_Device,
                dc_pin: Digital_IO,
            },
        };

        const Mode = switch (options.mode) {
            .dynamic => Driver_Mode,
            else => void,
        };

        dd: Datagram_Device,
        mode: Mode,
        dc_pin: Digital_IO,

        /// Initializes the device and sets up sane defaults.
        pub const init = switch (options.mode) {
            .i2c, .spi_3wire => init_without_io,
            .spi_4wire => init_with_io,
            .dynamic => init_with_mode,
        };

        /// Creates an instance with only a datagram device.
        /// `init` will be an alias to this if the init requires no D/C pin.
        fn init_without_io(dev: Datagram_Device) !Self {
            var self = Self{
                .dd = dev,
                .dc_pin = {},
                .mode = {},
            };
            try self.execute_init_sequence();
            return self;
        }

        /// Creates an instance with a datagram device and the D/C pin.
        /// `init` will be an alias to this if the init requires a D/C pin.
        fn init_with_io(dev: Datagram_Device, data_cmd_pin: Digital_IO) !Self {
            var self = Self{
                .dd = dev,
                .dc_pin = data_cmd_pin,
                .mode = {},
            };

            // The DC pin must be an output:
            try data_cmd_pin.set_direction(.output);

            try self.execute_init_sequence();

            return self;
        }

        fn init_with_mode(mode: Driver_Init_Mode) !Self {
            var self = Self{
                .dd = switch (mode) {
                    .i2c => |opt| opt.device,
                    .spi_3wire => @compileError("TODO"),
                    .spi_4wire => |opt| opt.device,
                },
                .dc_pin = switch (mode) {
                    .i2c => undefined,
                    .spi_3wire => @compileError("TODO"),
                    .spi_4wire => |opt| opt.dc_pin,
                },
                .mode = switch (mode) {
                    .i2c => .i2c,
                    .spi_3wire => .spi_3wire,
                    .spi_4wire => .spi_4wire,
                },
            };

            if (self.mode == .spi_4wire) {
                // The DC pin must be an output:
                try self.dc_pin.set_direction(.output);
            }

            try self.execute_init_sequence();

            return self;
        }

        /// Executes the device initialization sequence and sets up sane defaults.
        fn execute_init_sequence(self: Self) !void {
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
        }

        pub fn write_full_display(self: Self, data: *const [128 * 8]u8) !void {
            try self.set_memory_addressing_mode(.horizontal);
            try self.set_column_address(0, 127);
            try self.set_page_address(0, 7);

            try self.write_gdram(data);
        }

        pub fn write_gdram(self: Self, data: []const u8) !void {
            try self.write_data(data);
        }

        pub fn clear_screen(self: Self, white: bool) !void {
            try self.set_memory_addressing_mode(.horizontal);
            try self.set_column_address(0, 127);
            try self.set_page_address(0, 7);
            {
                const color: u8 = if (white) 0xFF else 0x00;

                const chunk_size = 16;

                const chunk: [chunk_size]u8 = @splat(color);

                const count = comptime @divExact(128 * 8, chunk.len);
                for (0..count) |_| {
                    try self.write_data(&chunk);
                }
            }
            try self.entire_display_on(.resumeToRam);
            try self.set_display(.on);
        }

        // Fundamental Commands
        pub fn set_contrast(self: Self, contrast: u8) !void {
            try self.execute_command(0x81, &.{contrast});
        }

        pub fn entire_display_on(self: Self, mode: DisplayOnMode) !void {
            try self.execute_command(@intFromEnum(mode), &.{});
        }

        pub fn set_normal_or_inverse_display(self: Self, mode: NormalOrInverseDisplay) !void {
            try self.execute_command(@intFromEnum(mode), &.{});
        }

        pub fn set_display(self: Self, mode: DisplayMode) !void {
            try self.execute_command(@intFromEnum(mode), &.{});
        }

        // Scrolling Commands
        pub fn continuous_horizontal_scroll_setup(self: Self, direction: HorizontalScrollDirection, start_page: u3, end_page: u3, frame_frequency: u3) !void {
            if (end_page < start_page)
                return PageError.EndPageIsSmallerThanStartPage;

            try self.execute_command(@intFromEnum(direction), &.{
                0x00, // Dummy byte
                @as(u8, start_page),
                @as(u8, frame_frequency),
                @as(u8, end_page),
                0x00, // Dummy byte
                0xFF, // Dummy byte
            });
        }

        pub fn continuous_vertical_and_horizontal_scroll_setup(self: Self, direction: VerticalAndHorizontalScrollDirection, start_page: u3, end_page: u3, frame_frequency: u3, vertical_scrolling_offset: u6) !void {
            try self.execute_command(@intFromEnum(direction), &.{
                0x00, // Dummy byte
                @as(u8, start_page),
                @as(u8, frame_frequency),
                @as(u8, end_page),
                @as(u8, vertical_scrolling_offset),
            });
        }

        pub fn deactivate_scroll(self: Self) !void {
            try self.execute_command(0x2E, &.{});
        }

        pub fn activate_scroll(self: Self) !void {
            try self.execute_command(0x2F, &.{});
        }

        pub fn set_vertical_scroll_area(self: Self, start_row: u6, num_of_rows: u7) !void {
            try self.execute_command(0xA3, &.{ @as(u8, start_row), @as(u8, num_of_rows) });
        }

        // Addressing Setting Commands
        pub fn set_column_start_address_for_page_addressing_mode(self: Self, column: Column, address: u4) !void {
            const cmd = (@as(u8, @intFromEnum(column)) << 4) | @as(u8, address);

            try self.execute_command(cmd, &.{});
        }

        pub fn set_memory_addressing_mode(self: Self, mode: MemoryAddressingMode) !void {
            try self.execute_command(0x20, &.{@as(u8, @intFromEnum(mode))});
        }

        pub fn set_column_address(self: Self, start: u7, end: u7) !void {
            try self.execute_command(0x21, &.{ @as(u8, start), @as(u8, end) });
        }

        pub fn set_page_address(self: Self, start: u3, end: u3) !void {
            try self.execute_command(0x22, &.{ @as(u8, start), @as(u8, end) });
        }

        pub fn set_page_start_address(self: Self, address: u3) !void {
            const cmd: u8 = 0xB0 | @as(u8, address);

            try self.execute_command(cmd, &.{});
        }

        // Hardware Configuration Commands
        pub fn set_display_start_line(self: Self, line: u6) !void {
            const cmd: u8 = 0x40 | @as(u8, line);

            try self.execute_command(cmd, &.{});
        }

        // false: column address 0 is mapped to SEG0
        // true: column address 127 is mapped to SEG0
        pub fn set_segment_remap(self: Self, remap: bool) !void {
            if (remap) {
                try self.execute_command(0xA1, &.{});
            } else {
                try self.execute_command(0xA0, &.{});
            }
        }

        pub fn set_multiplex_ratio(self: Self, ratio: u6) !void {
            if (ratio <= 14) return InputError.InvalidEntry;

            try self.execute_command(0xA8, &.{@as(u8, ratio)});
        }

        /// false: normal (COM0 to COMn)
        /// true: remapped
        pub fn set_com_ouput_scan_direction(self: Self, remap: bool) !void {
            if (remap) {
                try self.execute_command(0xC8, &.{});
            } else {
                try self.execute_command(0xC0, &.{});
            }
        }

        pub fn set_display_offset(self: Self, vertical_shift: u6) !void {
            try self.execute_command(0xD3, &.{@as(u8, vertical_shift)});
        }

        // TODO(philippwendel) Make config to enum
        pub fn set_com_pins_hardware_configuration(self: Self, config: u2) !void {
            try self.execute_command(0xDA, &.{@as(u8, config) << 4 | 0x02});
        }

        // Timing & Driving Scheme Setting Commands
        // TODO(philippwendel) Split in two funktions
        pub fn set_display_clock_divide_ratio_and_oscillator_frequency(self: Self, divide_ratio: u4, freq: u4) !void {
            try self.execute_command(0xD5, &.{(@as(u8, freq) << 4) | @as(u8, divide_ratio)});
        }

        pub fn set_precharge_period(self: Self, phase1: u4, phase2: u4) !void {
            if (phase1 == 0 or phase2 == 0) return InputError.InvalidEntry;

            try self.execute_command(0xD9, &.{@as(u8, phase2) << 4 | @as(u8, phase1)});
        }

        // TODO(philippwendel) Make level to enum
        pub fn set_v_comh_deselect_level(self: Self, level: u3) !void {
            try self.execute_command(0xDB, &.{@as(u8, level) << 4});
        }

        pub fn nop(self: Self) !void {
            try self.execute_command(0xE3, &.{});
        }

        // Charge Pump Commands
        pub fn charge_pump_setting(self: Self, enable: bool) !void {
            const arg: u8 = if (enable)
                0x14
            else
                0x10;

            try self.execute_command(0x8D, &.{arg});
        }

        // Utilities:

        const i2c_command_preamble: []const u8 = &.{I2C_ControlByte.command};
        const i2c_data_preamble: []const u8 = &.{I2C_ControlByte.data_stream};

        /// Sends command data to the SSD1306 controller.
        fn execute_command(self: Self, cmd: u8, argv: []const u8) !void {
            try self.set_dc_pin(.command);

            try self.dd.connect();
            defer self.dd.disconnect();

            const command_preamble: []const u8 = switch (options.mode) {
                .spi_3wire, .spi_4wire => "",
                .i2c => i2c_command_preamble,
                .dynamic => switch (self.mode) {
                    .i2c => i2c_command_preamble,
                    .spi_3wire, .spi_4wire => "",
                    .dynamic => unreachable,
                },
            };

            try self.dd.writev(&.{ command_preamble, &.{cmd}, argv });
        }

        /// Sends gdram data to the SSD1306 controller.
        fn write_data(self: Self, data: []const u8) !void {
            try self.set_dc_pin(.data);

            try self.dd.connect();
            defer self.dd.disconnect();

            const data_preamble: []const u8 = switch (options.mode) {
                .spi_3wire, .spi_4wire => "",
                .i2c => i2c_data_preamble,
                .dynamic => switch (self.mode) {
                    .i2c => i2c_data_preamble,
                    .spi_3wire, .spi_4wire => "",
                    .dynamic => unreachable,
                },
            };

            try self.dd.writev(&.{ data_preamble, data });
        }

        /// If present, sets the D/C pin to the required mode.
        /// NOTE: This function must be called *before* activating the device
        ///       via chip select, so before calling `dd.connect`!
        fn set_dc_pin(self: Self, mode: enum { command, data }) !void {
            switch (options.mode) {
                .i2c, .spi_3wire => return,
                .spi_4wire => {},
                .dynamic => if (self.mode != .spi_4wire)
                    return,
            }

            try self.dc_pin.write(switch (mode) {
                .command => .low,
                .data => .high,
            });
        }

        // Tests

        const TestDevice = mdf.base.Datagram_Device.Test_Device;

        // This is the command sequence created by SSD1306_I2C.init()
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
        test set_contrast {
            // Arrange
            for ([_]u8{ 0, 128, 255 }) |contrast| {
                var td = TestDevice.init_receiver_only();
                defer td.deinit();

                const expected_data = &[_]u8{ 0x00, 0x81, contrast };

                // Act
                const driver = try SSD1306_I2C.init(td.datagram_device());
                try driver.set_contrast(contrast);

                // Assert
                try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
            }
        }

        test entire_display_on {
            // Arrange
            for ([_]u8{ 0xA4, 0xA5 }, [_]DisplayOnMode{ DisplayOnMode.resumeToRam, DisplayOnMode.ignoreRam }) |data, mode| {
                var td = TestDevice.init_receiver_only();
                defer td.deinit();

                const expected_data = &[_]u8{ 0x00, data };
                // Act
                const driver = try SSD1306_I2C.init(td.datagram_device());
                try driver.entire_display_on(mode);
                // Assert
                try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
            }
        }

        test set_normal_or_inverse_display {
            // Arrange
            for ([_]u8{ 0xA6, 0xA7 }, [_]NormalOrInverseDisplay{ NormalOrInverseDisplay.normal, NormalOrInverseDisplay.inverse }) |data, mode| {
                var td = TestDevice.init_receiver_only();
                defer td.deinit();

                const expected_data = &[_]u8{ 0x00, data };
                // Act
                const driver = try SSD1306_I2C.init(td.datagram_device());
                try driver.set_normal_or_inverse_display(mode);
                // Assert
                try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
            }
        }

        test set_display {
            // Arrange
            for ([_]u8{ 0xAF, 0xAE }, [_]DisplayMode{ DisplayMode.on, DisplayMode.off }) |data, mode| {
                var td = TestDevice.init_receiver_only();
                defer td.deinit();

                const expected_data = &[_]u8{ 0x00, data };
                // Act
                const driver = try SSD1306_I2C.init(td.datagram_device());
                try driver.set_display(mode);
                // Assert
                try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
            }
        }

        // Scrolling Commands
        // TODO(philippwendel) Test more values and error
        test continuous_horizontal_scroll_setup {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.continuous_horizontal_scroll_setup(.right, 0, 0, 0);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test continuous_vertical_and_horizontal_scroll_setup {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0x29, 0x00, 0x01, 0x3, 0x2, 0x4 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.continuous_vertical_and_horizontal_scroll_setup(.right, 1, 2, 3, 4);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test deactivate_scroll {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0x2E };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.deactivate_scroll();
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test activate_scroll {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0x2F };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.activate_scroll();
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test set_vertical_scroll_area {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xA3, 0x00, 0x0F };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_vertical_scroll_area(0, 15);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        // Addressing Setting Commands
        test set_column_start_address_for_page_addressing_mode {
            // Arrange
            for ([_]Column{ Column.lower, Column.higher }, [_]u8{ 0x0F, 0x1F }) |column, data| {
                var td = TestDevice.init_receiver_only();
                defer td.deinit();

                const expected_data = &[_]u8{ 0x00, data };
                // Act
                const driver = try SSD1306_I2C.init(td.datagram_device());
                try driver.set_column_start_address_for_page_addressing_mode(column, 0xF);
                // Assert
                try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
            }
        }

        test set_memory_addressing_mode {
            // Arrange
            for ([_]MemoryAddressingMode{ .horizontal, .vertical, .page }) |mode| {
                var td = TestDevice.init_receiver_only();
                defer td.deinit();

                const expected_data = &[_]u8{ 0x00, 0x20, @as(u8, @intFromEnum(mode)) };
                // Act
                const driver = try SSD1306_I2C.init(td.datagram_device());
                try driver.set_memory_addressing_mode(mode);
                // Assert
                try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
            }
        }

        test set_column_address {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0x21, 0, 127 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_column_address(0, 127);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test set_page_address {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0x22, 0, 7 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_page_address(0, 7);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test set_page_start_address {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xB7 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_page_start_address(7);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        // Hardware Configuration Commands
        test set_display_start_line {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0b0110_0000 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_display_start_line(32);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test set_segment_remap {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_][]const u8{ &.{ 0x00, 0xA0 }, &.{ 0x00, 0xA1 } };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_segment_remap(false);
            try driver.set_segment_remap(true);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ expected_data);
        }

        test set_multiplex_ratio {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xA8, 15 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_multiplex_ratio(15);
            const err = driver.set_multiplex_ratio(0);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
            try std.testing.expectEqual(err, InputError.InvalidEntry);
        }

        test set_com_ouput_scan_direction {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_][]const u8{ &.{ 0x00, 0xC0 }, &.{ 0x00, 0xC8 } };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_com_ouput_scan_direction(false);
            try driver.set_com_ouput_scan_direction(true);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ expected_data);
        }

        test set_display_offset {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xD3, 17 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_display_offset(17);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test set_com_pins_hardware_configuration {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xDA, 0b0011_0010 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_com_pins_hardware_configuration(0b11);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        // Timing & Driving Scheme Setting Commands
        test set_display_clock_divide_ratio_and_oscillator_frequency {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xD5, 0x00 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_display_clock_divide_ratio_and_oscillator_frequency(0, 0);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test set_precharge_period {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xD9, 0b0001_0001 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_precharge_period(1, 1);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test set_v_comh_deselect_level {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xDB, 0b0011_0000 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.set_v_comh_deselect_level(0b011);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        test nop {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_]u8{ 0x00, 0xE3 };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.nop();
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ .{expected_data});
        }

        // Charge Pump Commands
        test charge_pump_setting {
            // Arrange
            var td = TestDevice.init_receiver_only();
            defer td.deinit();

            const expected_data = &[_][]const u8{ &.{ 0x00, 0x8D, 0x14 }, &.{ 0x00, 0x8D, 0x10 } };
            // Act
            const driver = try SSD1306_I2C.init(td.datagram_device());
            try driver.charge_pump_setting(true);
            try driver.charge_pump_setting(false);
            // Assert
            try td.expect_sent(&recorded_init_sequence ++ expected_data);
        }
    };
}

pub const Color = mdf.display.colors.BlackWhite;

/// A framebuffer suitable for operation with the SSD1306.
///
/// Its memory layout is equivalent to the one in the SSD1306 RAM,
/// and the framebuffer can be copied verbatim to the device.
pub const Framebuffer = struct {
    pub const width = 128;
    pub const height = 64;

    // layed out in 8 pages with 8*128 pixels each.
    // each page is column-major with the column encoded in the bits 0 (top) to 7 (bottom).
    // each byte in the page is a column left-to-right.
    // first page is thus columns 0..7, second page is 8..15 and so on.
    pixel_data: [8 * 128]u8,

    /// Initializes a new framebuffer with the given clear color.
    pub fn init(fill_color: Color) Framebuffer {
        var fb = Framebuffer{ .pixel_data = undefined };
        @memset(&fb.pixel_data, switch (fill_color) {
            .black => 0x00,
            .white => 0xFF,
        });
        return fb;
    }

    /// Returns a pointer to the bit stream that can be passed to the
    /// device.
    pub fn bit_stream(fb: *const Framebuffer) *const [8 * 128]u8 {
        return &fb.pixel_data;
    }

    /// Clears the framebuffer to `color`.
    pub fn clear(fb: *Framebuffer, color: Color) void {
        fb.* = .init(color);
    }

    /// Sets the pixel at (`x`, `y`) to `color`.
    pub fn set_pixel(fb: *Framebuffer, x: u7, y: u6, color: Color) void {
        const page: u3 = @truncate(y / 8);
        const bit: u3 = @truncate(y % 8);
        const mask: u8 = @as(u8, 1) << bit;

        const offset: usize = (@as(usize, page) << 7) + x;

        switch (color) {
            .black => fb.pixel_data[offset] &= ~mask,
            .white => fb.pixel_data[offset] |= mask,
        }
    }

    // Tests:

    test "Framebuffer.init" {
        // .white
        {
            const fb = Framebuffer.init(.white);
            for (fb.pixel_data) |chunk| {
                try std.testing.expectEqual(0xFF, chunk);
            }
        }

        // .black
        {
            const fb = Framebuffer.init(.black);
            for (fb.pixel_data) |chunk| {
                try std.testing.expectEqual(0x00, chunk);
            }
        }
    }

    test clear {
        // .white
        {
            var fb = Framebuffer.init(.black);
            fb.clear(.white);
            for (fb.pixel_data) |chunk| {
                try std.testing.expectEqual(0xFF, chunk);
            }
        }

        // .black
        {
            var fb = Framebuffer.init(.white);
            fb.clear(.black);
            for (fb.pixel_data) |chunk| {
                try std.testing.expectEqual(0x00, chunk);
            }
        }
    }

    test set_pixel {
        // .white
        {
            var fb = Framebuffer.init(.black);

            fb.set_pixel(0, 0, .white);
            try std.testing.expectEqual(0x01, fb.pixel_data[0]);

            for (fb.pixel_data[1..]) |chunk| {
                try std.testing.expectEqual(0x00, chunk);
            }
        }

        // .black
        {
            var fb = Framebuffer.init(.white);

            fb.set_pixel(0, 0, .black);
            try std.testing.expectEqual(0xFE, fb.pixel_data[0]);

            for (fb.pixel_data[1..]) |chunk| {
                try std.testing.expectEqual(0xFF, chunk);
            }
        }
    }
};

const I2C_ControlByte = packed struct(u8) {
    zero: u6 = 0,

    /// The D/C# bit determines the next data byte is acted as a command or a data. If the D/C# bit is
    /// set to logic “0”, it defines the following data byte as a command. If the D/C# bit is set to
    /// logic “1”, it defines the following data byte as a data which will be stored at the GDDRAM.
    /// The GDDRAM column address pointer will be increased by one automatically after each
    /// data write.
    mode: enum(u1) { command = 0, data = 1 },

    /// If the Co bit is set as logic “0”, the transmission of the following information will contain data bytes only.
    co_bit: u1,

    const command: u8 = @bitCast(I2C_ControlByte{
        .mode = .command,
        .co_bit = 0,
    });

    const data_byte: u8 = @bitCast(I2C_ControlByte{
        .mode = .data,
        .co_bit = 1,
    });

    const data_stream: u8 = @bitCast(I2C_ControlByte{
        .mode = .data,
        .co_bit = 0,
    });
};

comptime {
    std.debug.assert(I2C_ControlByte.command == 0x00);
    std.debug.assert(I2C_ControlByte.data_byte == 0xC0);
    std.debug.assert(I2C_ControlByte.data_stream == 0x40);
}

// Fundamental Commands
pub const DisplayOnMode = enum(u8) { resumeToRam = 0xA4, ignoreRam = 0xA5 };
pub const NormalOrInverseDisplay = enum(u8) { normal = 0xA6, inverse = 0xA7 };
pub const DisplayMode = enum(u8) { off = 0xAE, on = 0xAF };

// Scrolling Commands
pub const HorizontalScrollDirection = enum(u8) { right = 0x26, left = 0x27 };
pub const VerticalAndHorizontalScrollDirection = enum(u8) { right = 0x29, left = 0x2A };
pub const PageError = error{EndPageIsSmallerThanStartPage};

// Addressing Setting Commands
pub const Column = enum(u1) { lower = 0, higher = 1 };
pub const MemoryAddressingMode = enum(u2) { horizontal = 0b00, vertical = 0b01, page = 0b10 };

// Hardware Configuration Commands
pub const InputError = error{InvalidEntry};

test {
    _ = SSD1306_I2C;
    _ = Framebuffer;

    _ = SSD1306_Generic(.{
        .mode = .i2c,
    });

    _ = SSD1306_Generic(.{
        .mode = .spi_4wire,
    });

    _ = SSD1306_Generic(.{
        .mode = .dynamic,
    });
}
