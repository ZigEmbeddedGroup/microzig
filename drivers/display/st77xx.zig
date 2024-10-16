//!
//! Driver for the ST7735 and ST7789 for the 4-line serial protocol or 8-bit parallel interface
//!
//! This driver is a port of https://github.com/adafruit/Adafruit-ST7735-Library
//!
//! Datasheets:
//! - https://www.displayfuture.com/Display/datasheet/controller/ST7735.pdf
//! - https://www.waveshare.com/w/upload/e/e2/ST7735S_V1.1_20111121.pdf
//! - https://www.waveshare.com/w/upload/a/ae/ST7789_Datasheet.pdf
//!
const std = @import("std");
const mdf = @import("../framework.zig");
const Color = mdf.display.colors.RGB565;

pub const ST7735 = ST77xx_Generic(.{
    .device = .st7735,
});

pub const ST7789 = ST77xx_Generic(.{
    .device = .st7789,
});

pub const ST77xx_Options = struct {
    /// Which SST77xx device does the driver target?
    device: Device,

    /// Which datagram device interface should be used.
    Datagram_Device: type = mdf.base.Datagram_Device,

    /// Which digital i/o interface should be used.
    Digital_IO: type = mdf.base.Digital_IO,
};

pub fn ST77xx_Generic(comptime options: ST77xx_Options) type {
    return struct {
        const Driver = @This();
        const Datagram_Device = options.Datagram_Device;
        const Digital_IO = options.Digital_IO;

        const dev = switch (options.device) {
            .st7735 => ST7735_Device,
            .st7789 => ST7789_Device,
        };

        dd: Datagram_Device,
        dev_rst: Digital_IO,
        dev_datcmd: Digital_IO,

        resolution: Resolution,

        pub fn init(
            channel: Datagram_Device,
            rst: Digital_IO,
            data_cmd: Digital_IO,
            resolution: Resolution,
        ) !Driver {
            const dri = Driver{
                .dd = channel,
                .dev_rst = rst,
                .dev_datcmd = data_cmd,

                .resolution = resolution,
            };

            // initSPI(freq, spiMode);

            // Run init sequence
            //  uint8_t numCommands, cmd, numArgs;
            // uint16_t ms;

            // numCommands = pgm_read_byte(addr++); // Number of commands to follow
            // while (numCommands--) {              // For each command...
            //     cmd = pgm_read_byte(addr++);       // Read command
            //     numArgs = pgm_read_byte(addr++);   // Number of args to follow
            //     ms = numArgs & ST_CMD_DELAY;       // If hibit set, delay follows args
            //     numArgs &= ~ST_CMD_DELAY;          // Mask out delay bit
            //     sendCommand(cmd, addr, numArgs);
            //     addr += numArgs;

            //     if (ms) {
            //     ms = pgm_read_byte(addr++); // Read post-command delay time (ms)
            //     if (ms == 255)
            //         ms = 500; // If 255, delay for 500 ms
            //     delay(ms);
            //     }
            // }

            try dri.set_spi_mode(.data);

            return dri;
        }

        pub fn set_address_window(dri: Driver, x: u16, y: u16, w: u16, h: u16) !void {
            // x += _xstart;
            // y += _ystart;

            const xa = (@as(u32, x) << 16) | (x + w - 1);
            const ya = (@as(u32, y) << 16) | (y + h - 1);

            try dri.write_command(.caset, std.mem.asBytes(&xa)); // Column addr set
            try dri.write_command(.raset, std.mem.asBytes(&ya)); // Row addr set
            try dri.write_command(.ramwr, &.{}); // write to RAM
        }

        pub fn set_rotation(dri: Driver, rotation: Rotation) !void {
            var control_byte: u8 = madctl_rgb;

            switch (rotation) {
                .normal => {
                    control_byte = (madctl_mx | madctl_my | madctl_rgb);
                    // _xstart = _colstart;
                    // _ystart = _rowstart;
                },
                .right90 => {
                    control_byte = (madctl_my | madctl_mv | madctl_rgb);
                    // _ystart = _colstart;
                    // _xstart = _rowstart;
                },
                .upside_down => {
                    control_byte = (madctl_rgb);
                    // _xstart = _colstart;
                    // _ystart = _rowstart;
                },
                .left90 => {
                    control_byte = (madctl_mx | madctl_mv | madctl_rgb);
                    // _ystart = _colstart;
                    // _xstart = _rowstart;
                },
            }

            try dri.write_command(.madctl, &.{control_byte});
        }

        pub fn enable_display(dri: Driver, enable: bool) !void {
            try dri.write_command(if (enable) .dispon else .dispoff, &.{});
        }

        pub fn enable_tearing(dri: Driver, enable: bool) !void {
            try dri.write_command(if (enable) .teon else .teoff, &.{});
        }

        pub fn enable_sleep(dri: Driver, enable: bool) !void {
            try dri.write_command(if (enable) .slpin else .slpout, &.{});
        }

        pub fn invert_display(dri: Driver, inverted: bool) !void {
            try dri.write_command(if (inverted) .invon else .invoff, &.{});
        }

        pub fn set_pixel(dri: Driver, x: u16, y: u16, color: Color) !void {
            if (x >= dri.resolution.width or y >= dri.resolution.height) {
                return;
            }
            try dri.set_address_window(x, y, 1, 1);
            try dri.write_data(&.{color});
        }

        fn write_command(dri: Driver, cmd: Command, params: []const u8) !void {
            try dri.dd.connect();
            defer dri.dd.disconnect();

            try dri.set_spi_mode(.command);
            try dri.dd.write(&[_]u8{@intFromEnum(cmd)});
            try dri.set_spi_mode(.data);
            try dri.dd.write(params);
        }

        fn write_data(dri: Driver, data: []const Color) !void {
            try dri.dd.connect();
            defer dri.dd.disconnect();

            try dri.dd.write(std.mem.sliceAsBytes(data));
        }

        fn set_spi_mode(dri: Driver, mode: enum { data, command }) !void {
            try dri.dev_datcmd.write(switch (mode) {
                .command => .low,
                .data => .high,
            });
        }

        const cmd_delay = 0x80; // special signifier for command lists

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

            rdid1 = 0xDA,
            rdid2 = 0xDB,
            rdid3 = 0xDC,
            rdid4 = 0xDD,
        };

        const madctl_my = 0x80;
        const madctl_mx = 0x40;
        const madctl_mv = 0x20;
        const madctl_ml = 0x10;
        const madctl_rgb = 0x00;

        const ST7735_Device = struct {
            // some flags for initR() :(
            const INITR_GREENTAB = 0x00;
            const INITR_REDTAB = 0x01;
            const INITR_BLACKTAB = 0x02;
            const INITR_18GREENTAB = INITR_GREENTAB;
            const INITR_18REDTAB = INITR_REDTAB;
            const INITR_18BLACKTAB = INITR_BLACKTAB;
            const INITR_144GREENTAB = 0x01;
            const INITR_MINI160x80 = 0x04;
            const INITR_HALLOWING = 0x05;
            const INITR_MINI160x80_PLUGIN = 0x06;

            // Some register settings
            const ST7735_MADCTL_BGR = 0x08;
            const ST7735_MADCTL_MH = 0x04;

            const ST7735_FRMCTR1 = 0xB1;
            const ST7735_FRMCTR2 = 0xB2;
            const ST7735_FRMCTR3 = 0xB3;
            const ST7735_INVCTR = 0xB4;
            const ST7735_DISSET5 = 0xB6;

            const ST7735_PWCTR1 = 0xC0;
            const ST7735_PWCTR2 = 0xC1;
            const ST7735_PWCTR3 = 0xC2;
            const ST7735_PWCTR4 = 0xC3;
            const ST7735_PWCTR5 = 0xC4;
            const ST7735_VMCTR1 = 0xC5;

            const ST7735_PWCTR6 = 0xFC;

            const ST7735_GMCTRP1 = 0xE0;
            const ST7735_GMCTRN1 = 0xE1;

            // static const uint8_t PROGMEM
            // Bcmd[] = {                        // Init commands for 7735B screens
            //     18,                             // 18 commands in list:
            //     ST77XX_SWRESET,   ST_CMD_DELAY, //  1: Software reset, no args, w/delay
            //     50,                           //     50 ms delay
            //     ST77XX_SLPOUT,    ST_CMD_DELAY, //  2: Out of sleep mode, no args, w/delay
            //     255,                          //     255 = max (500 ms) delay
            //     ST77XX_COLMOD,  1+ST_CMD_DELAY, //  3: Set color mode, 1 arg + delay:
            //     0x05,                         //     16-bit color
            //     10,                           //     10 ms delay
            //     ST7735_FRMCTR1, 3+ST_CMD_DELAY, //  4: Frame rate control, 3 args + delay:
            //     0x00,                         //     fastest refresh
            //     0x06,                         //     6 lines front porch
            //     0x03,                         //     3 lines back porch
            //     10,                           //     10 ms delay
            //     ST77XX_MADCTL,  1,              //  5: Mem access ctl (directions), 1 arg:
            //     0x08,                         //     Row/col addr, bottom-top refresh
            //     ST7735_DISSET5, 2,              //  6: Display settings #5, 2 args:
            //     0x15,                         //     1 clk cycle nonoverlap, 2 cycle gate
            //                                     //     rise, 3 cycle osc equalize
            //     0x02,                         //     Fix on VTL
            //     ST7735_INVCTR,  1,              //  7: Display inversion control, 1 arg:
            //     0x0,                          //     Line inversion
            //     ST7735_PWCTR1,  2+ST_CMD_DELAY, //  8: Power control, 2 args + delay:
            //     0x02,                         //     GVDD = 4.7V
            //     0x70,                         //     1.0uA
            //     10,                           //     10 ms delay
            //     ST7735_PWCTR2,  1,              //  9: Power control, 1 arg, no delay:
            //     0x05,                         //     VGH = 14.7V, VGL = -7.35V
            //     ST7735_PWCTR3,  2,              // 10: Power control, 2 args, no delay:
            //     0x01,                         //     Opamp current small
            //     0x02,                         //     Boost frequency
            //     ST7735_VMCTR1,  2+ST_CMD_DELAY, // 11: Power control, 2 args + delay:
            //     0x3C,                         //     VCOMH = 4V
            //     0x38,                         //     VCOML = -1.1V
            //     10,                           //     10 ms delay
            //     ST7735_PWCTR6,  2,              // 12: Power control, 2 args, no delay:
            //     0x11, 0x15,
            //     ST7735_GMCTRP1,16,              // 13: Gamma Adjustments (pos. polarity), 16 args + delay:
            //     0x09, 0x16, 0x09, 0x20,       //     (Not entirely necessary, but provides
            //     0x21, 0x1B, 0x13, 0x19,       //      accurate colors)
            //     0x17, 0x15, 0x1E, 0x2B,
            //     0x04, 0x05, 0x02, 0x0E,
            //     ST7735_GMCTRN1,16+ST_CMD_DELAY, // 14: Gamma Adjustments (neg. polarity), 16 args + delay:
            //     0x0B, 0x14, 0x08, 0x1E,       //     (Not entirely necessary, but provides
            //     0x22, 0x1D, 0x18, 0x1E,       //      accurate colors)
            //     0x1B, 0x1A, 0x24, 0x2B,
            //     0x06, 0x06, 0x02, 0x0F,
            //     10,                           //     10 ms delay
            //     ST77XX_CASET,   4,              // 15: Column addr set, 4 args, no delay:
            //     0x00, 0x02,                   //     XSTART = 2
            //     0x00, 0x81,                   //     XEND = 129
            //     ST77XX_RASET,   4,              // 16: Row addr set, 4 args, no delay:
            //     0x00, 0x02,                   //     XSTART = 1
            //     0x00, 0x81,                   //     XEND = 160
            //     ST77XX_NORON,     ST_CMD_DELAY, // 17: Normal display on, no args, w/delay
            //     10,                           //     10 ms delay
            //     ST77XX_DISPON,    ST_CMD_DELAY, // 18: Main screen turn on, no args, delay
            //     255 },                        //     255 = max (500 ms) delay

            // Rcmd1[] = {                       // 7735R init, part 1 (red or green tab)
            //     15,                             // 15 commands in list:
            //     ST77XX_SWRESET,   ST_CMD_DELAY, //  1: Software reset, 0 args, w/delay
            //     150,                          //     150 ms delay
            //     ST77XX_SLPOUT,    ST_CMD_DELAY, //  2: Out of sleep mode, 0 args, w/delay
            //     255,                          //     500 ms delay
            //     ST7735_FRMCTR1, 3,              //  3: Framerate ctrl - normal mode, 3 arg:
            //     0x01, 0x2C, 0x2D,             //     Rate = fosc/(1x2+40) * (LINE+2C+2D)
            //     ST7735_FRMCTR2, 3,              //  4: Framerate ctrl - idle mode, 3 args:
            //     0x01, 0x2C, 0x2D,             //     Rate = fosc/(1x2+40) * (LINE+2C+2D)
            //     ST7735_FRMCTR3, 6,              //  5: Framerate - partial mode, 6 args:
            //     0x01, 0x2C, 0x2D,             //     Dot inversion mode
            //     0x01, 0x2C, 0x2D,             //     Line inversion mode
            //     ST7735_INVCTR,  1,              //  6: Display inversion ctrl, 1 arg:
            //     0x07,                         //     No inversion
            //     ST7735_PWCTR1,  3,              //  7: Power control, 3 args, no delay:
            //     0xA2,
            //     0x02,                         //     -4.6V
            //     0x84,                         //     AUTO mode
            //     ST7735_PWCTR2,  1,              //  8: Power control, 1 arg, no delay:
            //     0xC5,                         //     VGH25=2.4C VGSEL=-10 VGH=3 * AVDD
            //     ST7735_PWCTR3,  2,              //  9: Power control, 2 args, no delay:
            //     0x0A,                         //     Opamp current small
            //     0x00,                         //     Boost frequency
            //     ST7735_PWCTR4,  2,              // 10: Power control, 2 args, no delay:
            //     0x8A,                         //     BCLK/2,
            //     0x2A,                         //     opamp current small & medium low
            //     ST7735_PWCTR5,  2,              // 11: Power control, 2 args, no delay:
            //     0x8A, 0xEE,
            //     ST7735_VMCTR1,  1,              // 12: Power control, 1 arg, no delay:
            //     0x0E,
            //     ST77XX_INVOFF,  0,              // 13: Don't invert display, no args
            //     ST77XX_MADCTL,  1,              // 14: Mem access ctl (directions), 1 arg:
            //     0xC8,                         //     row/col addr, bottom-top refresh
            //     ST77XX_COLMOD,  1,              // 15: set color mode, 1 arg, no delay:
            //     0x05 },                       //     16-bit color

            // Rcmd2green[] = {                  // 7735R init, part 2 (green tab only)
            //     2,                              //  2 commands in list:
            //     ST77XX_CASET,   4,              //  1: Column addr set, 4 args, no delay:
            //     0x00, 0x02,                   //     XSTART = 0
            //     0x00, 0x7F+0x02,              //     XEND = 127
            //     ST77XX_RASET,   4,              //  2: Row addr set, 4 args, no delay:
            //     0x00, 0x01,                   //     XSTART = 0
            //     0x00, 0x9F+0x01 },            //     XEND = 159

            // Rcmd2red[] = {                    // 7735R init, part 2 (red tab only)
            //     2,                              //  2 commands in list:
            //     ST77XX_CASET,   4,              //  1: Column addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x7F,                   //     XEND = 127
            //     ST77XX_RASET,   4,              //  2: Row addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x9F },                 //     XEND = 159

            // Rcmd2green144[] = {               // 7735R init, part 2 (green 1.44 tab)
            //     2,                              //  2 commands in list:
            //     ST77XX_CASET,   4,              //  1: Column addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x7F,                   //     XEND = 127
            //     ST77XX_RASET,   4,              //  2: Row addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x7F },                 //     XEND = 127

            // Rcmd2green160x80[] = {            // 7735R init, part 2 (mini 160x80)
            //     2,                              //  2 commands in list:
            //     ST77XX_CASET,   4,              //  1: Column addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x4F,                   //     XEND = 79
            //     ST77XX_RASET,   4,              //  2: Row addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x9F },                 //     XEND = 159

            // Rcmd2green160x80plugin[] = {      // 7735R init, part 2 (mini 160x80 with plugin FPC)
            //     3,                              //  3 commands in list:
            //     ST77XX_INVON,  0,              //   1: Display is inverted
            //     ST77XX_CASET,   4,              //  2: Column addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x4F,                   //     XEND = 79
            //     ST77XX_RASET,   4,              //  3: Row addr set, 4 args, no delay:
            //     0x00, 0x00,                   //     XSTART = 0
            //     0x00, 0x9F },                 //     XEND = 159

            // Rcmd3[] = {                       // 7735R init, part 3 (red or green tab)
            //     4,                              //  4 commands in list:
            //     ST7735_GMCTRP1, 16      ,       //  1: Gamma Adjustments (pos. polarity), 16 args + delay:
            //     0x02, 0x1c, 0x07, 0x12,       //     (Not entirely necessary, but provides
            //     0x37, 0x32, 0x29, 0x2d,       //      accurate colors)
            //     0x29, 0x25, 0x2B, 0x39,
            //     0x00, 0x01, 0x03, 0x10,
            //     ST7735_GMCTRN1, 16      ,       //  2: Gamma Adjustments (neg. polarity), 16 args + delay:
            //     0x03, 0x1d, 0x07, 0x06,       //     (Not entirely necessary, but provides
            //     0x2E, 0x2C, 0x29, 0x2D,       //      accurate colors)
            //     0x2E, 0x2E, 0x37, 0x3F,
            //     0x00, 0x00, 0x02, 0x10,
            //     ST77XX_NORON,     ST_CMD_DELAY, //  3: Normal display on, no args, w/delay
            //     10,                           //     10 ms delay
            //     ST77XX_DISPON,    ST_CMD_DELAY, //  4: Main screen turn on, no args w/delay
            //     100 };                        //     100 ms delay
        };

        const ST7789_Device = struct {
            // static const uint8_t PROGMEM
            // generic_st7789[] =  {                // Init commands for 7789 screens
            //     9,                              //  9 commands in list:
            //     ST77XX_SWRESET,   ST_CMD_DELAY, //  1: Software reset, no args, w/delay
            //     150,                          //     ~150 ms delay
            //     ST77XX_SLPOUT ,   ST_CMD_DELAY, //  2: Out of sleep mode, no args, w/delay
            //     10,                          //      10 ms delay
            //     ST77XX_COLMOD , 1+ST_CMD_DELAY, //  3: Set color mode, 1 arg + delay:
            //     0x55,                         //     16-bit color
            //     10,                           //     10 ms delay
            //     ST77XX_MADCTL , 1,              //  4: Mem access ctrl (directions), 1 arg:
            //     0x08,                         //     Row/col addr, bottom-top refresh
            //     ST77XX_CASET  , 4,              //  5: Column addr set, 4 args, no delay:
            //     0x00,
            //     0,        //     XSTART = 0
            //     0,
            //     240,  //     XEND = 240
            //     ST77XX_RASET  , 4,              //  6: Row addr set, 4 args, no delay:
            //     0x00,
            //     0,             //     YSTART = 0
            //     320>>8,
            //     320&0xFF,  //     YEND = 320
            //     ST77XX_INVON  ,   ST_CMD_DELAY,  //  7: hack
            //     10,
            //     ST77XX_NORON  ,   ST_CMD_DELAY, //  8: Normal display on, no args, w/delay
            //     10,                           //     10 ms delay
            //     ST77XX_DISPON ,   ST_CMD_DELAY, //  9: Main screen turn on, no args, delay
            //     10 };                          //    10 ms delay
        };
    };
}

pub const Device = enum {
    st7735,
    st7789,
};

pub const Resolution = struct {
    width: u16,
    height: u16,
};

pub const Rotation = enum(u2) {
    normal,
    left90,
    right90,
    upside_down,
};

test {
    _ = ST7735;
    _ = ST7789;
}

test {
    var channel = mdf.base.Datagram_Device.Test_Device.init_receiver_only();
    defer channel.deinit();

    var rst_pin = mdf.base.Digital_IO.Test_Device.init(.output, .high);
    var dat_pin = mdf.base.Digital_IO.Test_Device.init(.output, .high);

    var dri = try ST7735.init(
        channel.datagram_device(),
        rst_pin.digital_io(),
        dat_pin.digital_io(),
        .{ .width = 128, .height = 128 },
    );

    try dri.set_address_window(16, 32, 48, 64);
    try dri.set_rotation(.normal);
    try dri.enable_display(true);
    try dri.enable_tearing(false);
    try dri.enable_sleep(true);
    try dri.invert_display(false);
    try dri.set_pixel(11, 15, Color.blue);
}
