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
    // Safe buffer size for RP2040 to allocate, value can change for other Chips
    // it has 256 kbs RAM buffer and I user 200kbs of it
    const RP_buffer_size = 200 * 1024;
    var backinf_buffer: [RP_buffer_size]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&backinf_buffer);

    const sda_pin = gpio.num(4);
    const scl_pin = gpio.num(5);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }

    rp2xxx.i2c.I2C.apply(i2c0, .{ .baud_rate = 400_000, .clock_config = rp2xxx.clock_config });

    const I2C_DEVICE = rp2xxx.drivers.I2C_Datagram_Device.init(i2c0, @enumFromInt(0x3C), null);
    const lcd = microzig.drivers.display.ssd1306.init(.i2c, I2C_DEVICE, null) catch unreachable;

    const print_val = four_rows ++ "    WELCOME";
    var buff: [print_val.len * 8]u8 = undefined;

    lcd.clear_screen(false) catch unreachable;
    lcd.write_gdram(font8x8.Fonts.draw(&buff, print_val)) catch unreachable;

    time.sleep_ms(2000);

    var counter: u8 = 0;
    while (true) : (time.sleep_ms(1000)) {
        var allocator = fba.allocator();
        var temp_buf: [7]u8 = undefined;
        const str = std.fmt.bufPrint(&temp_buf, "Try #{}", .{counter}) catch unreachable;
        var counter_buf: [80]u8 = undefined;
        const text_centered = centerToScreen(&counter_buf, str);

        const text = font8x8.Fonts.drawAlloc(allocator, text_centered) catch continue;
        defer allocator.free(text);

        lcd.clear_screen(false) catch continue;
        lcd.write_gdram(text) catch continue;

        counter += 1;
        if (counter > 59)
            break;
    }
}

fn centerToScreen(buf: []u8, str: []u8) []u8 {
    const ldc_row_len = empty_row.len; // 16
    const four_rows_len = four_rows.len; // 64
    const to_be_added = @divTrunc(ldc_row_len - str.len, 2);

    @memcpy(buf[0..four_rows_len], four_rows);

    for (0..to_be_added) |i| {
        @memcpy(buf[(four_rows_len + i)..(four_rows_len + i + 1)], " ");
    }

    @memcpy(
        buf[(four_rows_len + to_be_added)..(four_rows_len + to_be_added + str.len)],
        str,
    );

    for ((four_rows_len + to_be_added + str.len)..buf.len) |i| {
        @memcpy(buf[i..(i + 1)], " ");
    }

    return buf;
}
