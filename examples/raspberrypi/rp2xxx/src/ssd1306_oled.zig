const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const i2c = rp2xxx.i2c;
const font8x8 = @import("font8x8");

const i2c0 = i2c.instance.num(0);
const empty_row: []const u8 = " " ** 16;
const four_rows = empty_row ** 4;

pub fn main() void {
    // Safe buffer size for rp2xxx to allocate, value can change for other chips
    const buffer_size = 200 * 1024; // 200 KB
    var backinf_buffer: [buffer_size]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&backinf_buffer);

    const sda_pin = gpio.num(8);
    const scl_pin = gpio.num(9);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }

    rp2xxx.i2c.I2C.apply(i2c0, .{ .baud_rate = 400_000, .clock_config = rp2xxx.clock_config });

    const i2c_dd = rp2xxx.drivers.I2C_Datagram_Device.init(i2c0, @enumFromInt(0x3C), null);
    const lcd = microzig.drivers.display.ssd1306.init(.i2c, i2c_dd, null) catch unreachable;

    const print_val = four_rows ++ "    WELCOME";
    var buff: [print_val.len * 8]u8 = undefined;

    lcd.clear_screen(false) catch unreachable;
    lcd.write_gdram(font8x8.Fonts.draw(&buff, print_val)) catch unreachable;

    time.sleep_ms(2000);

    for (0..60) |i| {
        var aa = std.heap.ArenaAllocator.init(fba.allocator());
        defer aa.deinit();
        var temp_buf: [7]u8 = undefined;
        const str = std.fmt.bufPrint(&temp_buf, "Try #{}", .{i}) catch unreachable;
        var counter_buf: [80]u8 = undefined;
        const text_centered = center_to_screen(&counter_buf, str);

        const text = font8x8.Fonts.drawAlloc(aa.allocator(), text_centered) catch continue;

        lcd.clear_screen(false) catch continue;
        lcd.write_gdram(text) catch continue;

        time.sleep_ms(1000);
    }
}

fn center_to_screen(buf: []u8, str: []u8) []u8 {
    const ldc_row_len = empty_row.len;
    const four_rows_len = four_rows.len;
    const padding = @divTrunc(ldc_row_len - str.len, 2);

    // Copy the initial four rows (Could just memset)
    @memcpy(buf[0..four_rows_len], four_rows);

    // Add left padding
    const left_pad_start = four_rows_len;
    const left_pad_end = left_pad_start + padding;
    @memset(buf[left_pad_start..left_pad_end], ' ');

    // Copy the centered string
    const str_start = left_pad_end;
    const str_end = str_start + str.len;
    @memcpy(buf[str_start..str_end], str);

    // Add right padding
    @memset(buf[str_end..buf.len], ' ');
    return buf;
}
