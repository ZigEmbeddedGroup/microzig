//!
//! Driver for the ST7735 and ST7789 for the 4-line serial protocol or 8-bit parallel interface
//!
//!
//! Datasheets:
//! - https://www.displayfuture.com/Display/datasheet/controller/ST7735.pdf
//! - https://www.waveshare.com/w/upload/e/e2/ST7735S_V1.1_20111121.pdf
//! - https://www.waveshare.com/w/upload/a/ae/ST7789_Datasheet.pdf
//!
const std = @import("std");
const mdf = @import("../framework.zig");

pub fn ST7735(display_cfg: Display_Config) type {
    return ST77xx_Generic(.{
        .device = .st7735,
    }, display_cfg);
}

pub fn ST7789(display_cfg: Display_Config) type {
    return ST77xx_Generic(.{
        .device = .st7789,
    }, display_cfg);
}

pub const Device = enum {
    st7735,
    st7789,
};

pub const Resolution = struct {
    width: u16,
    height: u16,
};

const ColorOrder = enum(u1) {
    rgb = 0,
    bgr = 1,
};

const Rotation = enum(u2) {
    deg0,
    deg90,
    deg180,
    deg270,
};

pub const Driver_Config = struct {
    /// Which SST77xx device does the driver target?
    device: Device,

    /// Which datagram device interface should be used.
    Datagram_Device: type = mdf.base.Datagram_Device,

    /// Which digital i/o interface should be used.
    Digital_IO: type = mdf.base.Digital_IO,

    /// Which color format should be used when writing pixel data.
    Color: type = mdf.display.colors.RGB565_Generic(.big),
};

pub const Display_Config = struct {
    const Self = @This();
    /// Native panel resolution in pixels.
    resolution: Resolution,

    /// Horizontal RAM offset applied when setting the address window.
    ///
    /// Some ST77xx modules expose a visible area smaller than controller RAM.
    /// Use this to shift drawing into the visible window.
    x_offset: u16 = 0,

    /// Vertical RAM offset applied when setting the address window.
    y_offset: u16 = 0,

    /// Secondary horizontal RAM offset for rotated display states.
    x_offset2: u16 = 0,

    /// Secondary vertical RAM offset for rotated display states.
    y_offset2: u16 = 0,

    /// Color channel order written to MADCTL (RGB or BGR).
    color_order: ColorOrder = .rgb,

    /// If true, send `INVON` during initialization.
    display_inversion: bool = false,

    /// Initial display rotation used to initialize MADCTL.
    rotation: Rotation = .deg0,

    /// Preset for common ST7735 mini 160x80 modules that use BGR order,
    /// require display inversion, and have a shifted visible window.
    pub const lcd160x80bgr: Self = .{
        .resolution = .{ .width = 80, .height = 160 },
        .x_offset = 26,
        .y_offset = 1,
        .x_offset2 = 26,
        .y_offset2 = 1,
        .color_order = .bgr,
        .display_inversion = true,
    };

    /// Preset for common 240x240 modules with RGB color order and no display inversion.
    pub const lcd240x240rgb: Self = .{
        .resolution = .{ .width = 240, .height = 240 },
        .x_offset = 0,
        .y_offset = 0,
        .x_offset2 = 0,
        .y_offset2 = 80,
        .color_order = .rgb,
        .display_inversion = true,
    };
};

pub fn ST77xx_Generic(driver_cfg: Driver_Config, display_cfg: Display_Config) type {
    return struct {
        const Self = @This();
        const Datagram_Device = driver_cfg.Datagram_Device;
        const Digital_IO = driver_cfg.Digital_IO;
        pub const Color = driver_cfg.Color;

        dd: Datagram_Device,
        dev_rst: Digital_IO,
        dev_datcmd: Digital_IO,
        madctl: MemoryDataAccessControl,

        resolution: Resolution = display_cfg.resolution,
        x_offset: u16 = display_cfg.x_offset,
        y_offset: u16 = display_cfg.y_offset,

        pub fn init(
            channel: Datagram_Device,
            rst: Digital_IO,
            data_cmd: Digital_IO,
            delay_ms: *const fn (ms: u32) void,
        ) !Self {
            var dri = Self{
                .dd = channel,
                .dev_rst = rst,
                .dev_datcmd = data_cmd,

                .madctl = .{ .rgb = display_cfg.color_order, .addr = MemoryDataAccessControl.AddressOrder.from_rotation(display_cfg.rotation) },
            };

            try dri.set_spi_mode(.data);

            try dri.hard_reset(delay_ms);
            try dri.init_sequence(delay_ms);

            return dri;
        }

        fn set_spi_mode(dri: *Self, mode: enum { data, command }) !void {
            try dri.dev_datcmd.write(switch (mode) {
                .command => .low,
                .data => .high,
            });
        }

        fn hard_reset(dri: *Self, delay_ms: *const fn (ms: u32) void) !void {
            try dri.dev_rst.write(.high);
            delay_ms(200);
            try dri.dev_rst.write(.low);
            delay_ms(200);
            try dri.dev_rst.write(.high);
            delay_ms(200);
        }

        inline fn range_to_bigendian_bytes(start: u16, end: u16) [4]u8 {
            return .{ @as(u8, @truncate(start >> 8)), @as(u8, @truncate(start)), @as(u8, @truncate(end >> 8)), @as(u8, @truncate(end)) };
        }

        // Initialization sequences based on datasheet recommendations and the Adafruit ST7735 library:
        // https://github.com/adafruit/Adafruit-ST7735-Library
        inline fn init_sequence(dri: *Self, delay_ms: *const fn (ms: u32) void) !void {
            switch (comptime driver_cfg.device) {
                .st7735 => try dri.init_sequence_st7735(delay_ms),
                .st7789 => try dri.init_sequence_st7789(delay_ms),
            }
        }

        fn init_sequence_st7735(dri: *Self, delay_ms: *const fn (ms: u32) void) !void {
            // Reset the controller and exit sleep mode.
            try dri.write_command(.swreset, &.{});
            delay_ms(150);
            try dri.write_command(.slpout, &.{});
            delay_ms(500);

            // Configure frame rate and inversion behaviour for stable scanning.
            try dri.write_command(.frmctr1, &.{ 0x01, 0x2C, 0x2D });
            try dri.write_command(.frmctr2, &.{ 0x01, 0x2C, 0x2D });
            try dri.write_command(.frmctr3, &.{ 0x01, 0x2C, 0x2D, 0x01, 0x2C, 0x2D });

            try dri.write_command(.invctr, &.{0x07});

            // Power control and VCOM tuning values from common reference init tables.
            try dri.write_command(.pwmctr1, &.{ 0xA2, 0x02, 0x84 });
            try dri.write_command(.pwmctr2, &.{0xC5});
            try dri.write_command(.pwmctr3, &.{ 0x0A, 0x00 });
            try dri.write_command(.pwmctr4, &.{ 0x8A, 0x2A });
            try dri.write_command(.pwmctr5, &.{ 0x8A, 0xEE });

            try dri.write_command(.vmctr1, &.{0x0E});
            try dri.write_command(.invoff, &.{});

            // Select 16-bit pixel format and apply orientation / color order.
            try dri.write_command(.madctl, &.{@bitCast(dri.madctl)});
            try dri.write_command(.colmod, &.{0x05});

            // Expose the full configured panel area as the initial drawing window.
            try dri.write_command(.caset, &range_to_bigendian_bytes(0, display_cfg.resolution.width - 1));
            try dri.write_command(.raset, &range_to_bigendian_bytes(0, display_cfg.resolution.height - 1));

            // Some modules require display inversion for correct colours / contrast.
            if (comptime display_cfg.display_inversion) {
                try dri.write_command(.invon, &.{});
            }

            // Positive and negative gamma correction curves.
            try dri.write_command(.gmctrp1, &.{
                0x02, 0x1c, 0x07, 0x12, 0x37, 0x32, 0x29, 0x2d,
                0x29, 0x25, 0x2B, 0x39, 0x00, 0x01, 0x03, 0x10,
            });

            try dri.write_command(.gmctrn1, &.{
                0x03, 0x1d, 0x07, 0x06, 0x2E, 0x2C, 0x29, 0x2D,
                0x2E, 0x2E, 0x37, 0x3F, 0x00, 0x00, 0x02, 0x10,
            });

            // Switch to normal mode and enable display output.
            try dri.write_command(.noron, &.{});
            delay_ms(10);
            try dri.write_command(.dispon, &.{});
            delay_ms(100);
        }

        fn init_sequence_st7789(dri: *Self, delay_ms: *const fn (ms: u32) void) !void {
            // Reset the controller and exit sleep mode.
            try dri.write_command(.swreset, &.{});
            delay_ms(150);
            try dri.write_command(.slpout, &.{});
            delay_ms(10);

            // Select 16-bit pixel format and apply orientation / color order.
            try dri.write_command(.colmod, &.{0x55});
            delay_ms(10);
            try dri.write_command(.madctl, &.{@bitCast(dri.madctl)});

            // Expose the full configured panel area as the initial drawing window.
            try dri.write_command(.caset, &range_to_bigendian_bytes(0, display_cfg.resolution.width - 1));
            try dri.write_command(.raset, &range_to_bigendian_bytes(0, display_cfg.resolution.height - 1));

            // Some modules require display inversion for correct colours / contrast.
            if (comptime display_cfg.display_inversion) {
                try dri.write_command(.invon, &.{});
                delay_ms(10);
            }

            // Switch to normal mode and enable display output.
            try dri.write_command(.noron, &.{});
            delay_ms(10);
            try dri.write_command(.dispon, &.{});
            delay_ms(10);
        }

        pub fn set_address_window(dri: *Self, x: u16, y: u16, w: u16, h: u16) !void {
            const xstart = x + dri.x_offset;
            const ystart = y + dri.y_offset;
            const xend = xstart + (w - 1);
            const yend = ystart + (h - 1);

            try dri.write_command(.caset, &range_to_bigendian_bytes(xstart, xend));
            try dri.write_command(.raset, &range_to_bigendian_bytes(ystart, yend));
            try dri.write_command(.ramwr, &.{});
        }

        pub fn push_colors(dri: *Self, colors: []align(1) const Color) !void {
            try dri.set_spi_mode(.data);

            try dri.dd.connect();
            defer dri.dd.disconnect();

            try dri.dd.write(std.mem.sliceAsBytes(colors));
        }

        pub fn get_active_resolution(dri: *const Self) Resolution {
            return dri.resolution;
        }

        pub fn set_rotation(dri: *Self, rotation: Rotation) !void {
            switch (rotation) {
                .deg0 => {
                    dri.madctl.addr = MemoryDataAccessControl.AddressOrder.from_rotation(rotation);
                    dri.resolution.width = display_cfg.resolution.width;
                    dri.resolution.height = display_cfg.resolution.height;
                    dri.x_offset = display_cfg.x_offset;
                    dri.y_offset = display_cfg.y_offset;
                },
                .deg90 => {
                    dri.madctl.addr = MemoryDataAccessControl.AddressOrder.from_rotation(rotation);
                    dri.resolution.width = display_cfg.resolution.height;
                    dri.resolution.height = display_cfg.resolution.width;
                    dri.x_offset = display_cfg.y_offset;
                    dri.y_offset = display_cfg.x_offset2;
                },
                .deg180 => {
                    dri.madctl.addr = MemoryDataAccessControl.AddressOrder.from_rotation(rotation);
                    dri.resolution.width = display_cfg.resolution.width;
                    dri.resolution.height = display_cfg.resolution.height;
                    dri.x_offset = display_cfg.x_offset2;
                    dri.y_offset = display_cfg.y_offset2;
                },
                .deg270 => {
                    dri.madctl.addr = MemoryDataAccessControl.AddressOrder.from_rotation(rotation);
                    dri.resolution.width = display_cfg.resolution.height;
                    dri.resolution.height = display_cfg.resolution.width;
                    dri.x_offset = display_cfg.y_offset2;
                    dri.y_offset = display_cfg.x_offset;
                },
            }

            try dri.write_command(.madctl, &.{@bitCast(dri.madctl)});
        }

        fn write_command(dri: *Self, cmd: Command, params: []const u8) !void {
            try dri.set_spi_mode(.command);
            try dri.dd.connect();
            defer dri.dd.disconnect();

            try dri.dd.write(&[_]u8{@intFromEnum(cmd)});

            try dri.set_spi_mode(.data);
            try dri.dd.write(params);
        }

        const Command = enum(u8) {
            nop = 0x00,
            swreset = 0x01,
            rddid = 0x04,
            rddst = 0x09,

            slpin = 0x10,
            slpout = 0x11,
            ptlon = 0x12,
            noron = 0x13,

            invoff = 0x20,
            invon = 0x21,
            dispoff = 0x28,
            dispon = 0x29,
            caset = 0x2A,
            raset = 0x2B,
            ramwr = 0x2C,
            ramrd = 0x2E,

            ptlar = 0x30,
            teoff = 0x34,
            teon = 0x35,
            madctl = 0x36,
            colmod = 0x3A,

            frmctr1 = 0xB1,
            frmctr2 = 0xB2,
            frmctr3 = 0xB3,
            invctr = 0xB4,
            disset5 = 0xB6,

            pwmctr1 = 0xC0,
            pwmctr2 = 0xC1,
            pwmctr3 = 0xC2,
            pwmctr4 = 0xC3,
            pwmctr5 = 0xC4,
            vmctr1 = 0xC5,

            rdid1 = 0xDA,
            rdid2 = 0xDB,
            rdid3 = 0xDC,
            rdid4 = 0xDD,

            gmctrp1 = 0xE0,
            gmctrn1 = 0xE1,
        };
    };
}

const MemoryDataAccessControl = packed struct(u8) {
    _reserved: u2 = 0,
    mh: HorizontalRefreshOrder = .left_to_right,
    rgb: ColorOrder = .rgb,
    ml: VerticalRefreshOrder = .top_to_bottom,
    addr: AddressOrder = .deg0,

    const HorizontalRefreshOrder = enum(u1) {
        left_to_right = 0,
        right_to_left = 1,
    };

    const VerticalRefreshOrder = enum(u1) {
        top_to_bottom = 0,
        bottom_to_top = 1,
    };

    const AddressOrder = packed struct(u3) {
        const Self = @This();
        mv: u1,
        mx: u1,
        my: u1,

        pub fn from_rotation(rotation: Rotation) Self {
            return switch (rotation) {
                .deg0 => Self.deg0,
                .deg90 => Self.deg90,
                .deg180 => Self.deg180,
                .deg270 => Self.deg270,
            };
        }

        pub const deg0: Self = .{ .mv = 0, .mx = 0, .my = 0 };
        pub const deg90: Self = .{ .mv = 1, .mx = 1, .my = 0 };
        pub const deg180: Self = .{ .mv = 0, .mx = 1, .my = 1 };
        pub const deg270: Self = .{ .mv = 1, .mx = 0, .my = 1 };
    };
};
