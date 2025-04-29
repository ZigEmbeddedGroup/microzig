//!
//! Generic driver for the SH1106 display controller.
//!
//! This controller is usually found in small OLED displays.
//!
//! Datasheets:
//! https://cdn.sparkfun.com/assets/2/6/8/9/7/1.3inch-SH1106-OLED_Datasheet.pdf
//! https://www.pololu.com/file/0J1813/SH1106.pdf
//!

const std = @import("std");
const mdf = @import("../framework.zig");
const common = @import("common.zig");

const I2C_ControlByte = common.I2C_ControlByte;

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

pub const Options = struct {
    /// Defines the operation of the SH1106 driver.
    mode: Driver_Mode,

    /// Which datagram device interface should be used.
    Datagram_Device: type = mdf.base.Datagram_Device,

    /// Which digital i/o interface should be used.
    Digital_IO: type = mdf.base.Digital_IO,
};

pub const DisplayOnMode = enum(u8) { resume_to_ram = 0xA4, ignore_ram = 0xA5 };
pub const NormalOrInverseDisplay = enum(u8) { normal = 0xA6, inverse = 0xA7 };
pub const DisplayMode = enum(u8) { off = 0xAE, on = 0xAF };

pub const InputError = error{InvalidEntry};

const cols = 132;
const rows = 64;

pub fn SH1106(comptime options: Options) type {
    switch (options.mode) {
        .i2c, .spi_4wire, .dynamic => {},
        .spi_3wire => @compileError("3-wire SPI operation is not supported yet!"),
    }

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
            try self.set_lower_column_address(2);
            try self.set_upper_column_address(0);
            try self.set_display_start_line(0);
            try self.set_page_address(0);
            try self.set_contrast(255);
            try self.set_segment_remap(.left);
            try self.set_com_output_scan_direction(.flipped);
            try self.set_normal_or_inverse_color(.normal);
            try self.set_multiplex_ratio(63);
            try self.charge_pump_setting(true);
            try self.set_pump_voltage(.@"9.0");
            try self.set_display_offset(0);
            try self.set_display_clock_divide_ratio_and_oscillator_frequency(0, 8);
            try self.set_precharge_period(2, 2);
            try self.set_com_pins_hardware_configuration(.alternative);
            try self.set_v_comh_deselect_level(0x40);
            try self.entire_display_on(.resume_to_ram);
            try self.set_display(.on);
        }

        pub fn write_full_display(self: Self, data: *const [cols * 8]u8) !void {
            for (0..8) |page| {
                try self.set_page_address(@intCast(page));
                const start = cols * page;
                const end = start + cols;
                try self.write_gdram(data[start..end]);
            }
        }

        pub fn write_gdram(self: Self, data: []const u8) !void {
            try self.write_data(data);
        }

        pub fn clear_screen(self: Self, white: bool) !void {
            const color: u8 = if (white) 0xFF else 0x00;
            for (0..8) |page| {
                try self.set_page_address(@intCast(page));
                const page_data: [cols]u8 = @splat(color);
                try self.write_data(&page_data);
            }
            try self.entire_display_on(.resume_to_ram);
            try self.set_display(.on);
        }

        pub fn set_contrast(self: Self, contrast: u8) !void {
            try self.execute_command(0x81, &.{contrast});
        }

        pub fn entire_display_on(self: Self, mode: DisplayOnMode) !void {
            try self.execute_command(@intFromEnum(mode), &.{});
        }

        pub fn set_normal_or_inverse_color(self: Self, mode: NormalOrInverseDisplay) !void {
            try self.execute_command(@intFromEnum(mode), &.{});
        }

        pub fn set_display(self: Self, mode: DisplayMode) !void {
            try self.execute_command(@intFromEnum(mode), &.{});
        }

        pub fn set_lower_column_address(self: Self, addr: u2) !void {
            try self.execute_command(addr, &.{});
        }

        /// addr is masked with 0x10 to determine the last column index in the range 127 to 131.
        pub fn set_upper_column_address(self: Self, addr: u2) !void {
            const cmd = 0x10 | @as(u8, addr);
            try self.execute_command(cmd, &.{});
        }

        pub fn set_page_address(self: Self, addr: u3) !void {
            const cmd = 0xB0 | @as(u8, addr);
            try self.execute_command(cmd, &.{});
        }

        pub fn set_display_start_line(self: Self, line: u6) !void {
            const cmd: u8 = 0x40 | @as(u8, line);
            try self.execute_command(cmd, &.{});
        }

        // Rotates RAM to the left or right in relation to the display segments.
        pub fn set_segment_remap(self: Self, direction: enum { left, right }) !void {
            const cmd: u8 = switch (direction) {
                .left => 0xA1,
                .right => 0xA0,
            };
            try self.execute_command(cmd, &.{});
        }

        pub fn set_multiplex_ratio(self: Self, ratio: u6) !void {
            try self.execute_command(0xA8, &.{@as(u8, ratio)});
        }

        /// `flipped` vertically flips the display.
        pub fn set_com_output_scan_direction(self: Self, remap: enum { normal, flipped }) !void {
            const cmd: u8 = switch (remap) {
                .normal => 0xC0,
                .flipped => 0xC8,
            };
            try self.execute_command(cmd, &.{});
        }

        pub fn set_display_offset(self: Self, vertical_shift: u6) !void {
            try self.execute_command(0xD3, &.{@as(u8, vertical_shift)});
        }

        pub fn set_com_pins_hardware_configuration(self: Self, mode: enum { sequential, alternative }) !void {
            const arg: u8 = switch (mode) {
                .sequential => 0x02,
                .alternative => 0x12,
            };
            try self.execute_command(0xDA, &.{arg});
        }

        /// Ratio is `divide_ratio` + 1.
        /// Frequency changes in 5% increments above/below `freq`, with 0x05 being 0%.
        pub fn set_display_clock_divide_ratio_and_oscillator_frequency(self: Self, divide_ratio: u4, freq: u4) !void {
            try self.execute_command(0xD5, &.{(@as(u8, freq) << 4) | @as(u8, divide_ratio)});
        }

        pub fn set_precharge_period(self: Self, precharge: u4, discharge: u4) !void {
            if (precharge == 0 or discharge == 0) return InputError.InvalidEntry;
            try self.execute_command(0xD9, &.{@as(u8, discharge) << 4 | @as(u8, precharge)});
        }

        pub fn set_v_comh_deselect_level(self: Self, level: u8) !void {
            try self.execute_command(0xDB, &.{level});
        }

        pub fn nop(self: Self) !void {
            try self.execute_command(0xE3, &.{});
        }

        pub fn charge_pump_setting(self: Self, enable: bool) !void {
            const arg: u8 = if (enable) 0x8B else 0x8A;
            try self.execute_command(0xAD, &.{arg});
        }

        /// Set output voltage (Vpp) of internal charge pump.
        pub fn set_pump_voltage(self: Self, voltage: enum(u2) {
            @"6.4",
            @"7.4",
            @"8.0",
            @"9.0",
        }) !void {
            const cmd: u8 = 0x30 | @as(u8, @intFromEnum(voltage));
            try self.execute_command(cmd, &.{});
        }

        const i2c_command_preamble: []const u8 = &.{I2C_ControlByte.command};
        const i2c_data_preamble: []const u8 = &.{I2C_ControlByte.data_stream};

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
    };
}

test {
    _ = SH1106(.{ .mode = .i2c });
    _ = SH1106(.{ .mode = .spi_4wire });
    _ = SH1106(.{ .mode = .dynamic });
}
