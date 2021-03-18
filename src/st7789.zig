const delay = @import("main.zig").delay; // TODO

pub fn ST7789(comptime SPI_: type, comptime RESET_: type, comptime DC_: type) type {
    return struct {
        const SPI_INTERNAL = SPI_;
        const RESET = RESET_;
        const DC = DC_;

        pub fn init() void {
            hard_reset();
            soft_reset();
            sleep_mode(false);

            set_color_mode();
            set_mem_access_mode();

            write_cmd(0x2a, .{ 0x00, 0x00, 0x00, 240 });
            delay(10);

            write_cmd(0x2b, .{ 0x00, 0x00, 0x00, 240 });
            delay(10);

            inversion_mode(true);
            delay(10);

            write_cmd(0x13, null);
            delay(10);

            write_cmd(0x29, null);
            delay(500);
        }

        fn write_cmd(cmd: u16, data: anytype) callconv(.Inline) void {
            DC.clr();
            SPI_INTERNAL.write(cmd);
            DC.set();
            if (@TypeOf(data) != @TypeOf(null)) {
                inline for (data) |d| {
                    SPI_INTERNAL.write(d);
                }
            }
        }

        fn hard_reset() callconv(.Inline) void {
            RESET.clr();
            delay(50);
            RESET.set();
            delay(50);
            RESET.clr();
            delay(50);
            RESET.set();
            delay(200);
        }

        fn soft_reset() callconv(.Inline) void {
            write_cmd(0x01, null);
            delay(150);
        }

        pub fn sleep_mode(value: bool) callconv(.Inline) void {
            write_cmd(if (value) 0x10 else 0x11, null);
            delay(10);
        }

        pub fn set_color_mode() void {
            write_cmd(0x3a, .{0x55});
            delay(50);
        }

        pub fn set_mem_access_mode() void {
            write_cmd(0x36, .{0x80 | 0x40});
            delay(10);
        }

        pub fn inversion_mode(comptime value: bool) void {
            write_cmd(if (value) 0x21 else 0x20, null);
            delay(10);
        }

        pub fn set_columns(comptime start: u16, comptime end: u16) void {
            write_cmd(0x2a, .{ start >> 8, start & 0xff, end >> 8, end & 0xff });
        }

        pub fn set_rows(comptime start: u16, comptime end: u16) void {
            write_cmd(0x2b, .{ start >> 8, start & 0xff, end >> 8, end & 0xff });
        }

        pub fn ramwr() void {
            write_cmd(0x2c, .{});
        }

        pub fn write_pixel(comptime data_: u16) void {
            DC.set();
            const data = .{ data_ >> 8, data_ & 0xff };
            inline for (data) |d| {
                SPI_INTERNAL.write(d);
            }
        }

        pub fn write_pixels(data: []u8) void {
            DC.set();
            var offset: u32 = 0;
            for (data) |d| {
                SPI_INTERNAL.write(d);
                offset = offset + 1;
            }
        }
    };
}
