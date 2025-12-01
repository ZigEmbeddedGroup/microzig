const microzig = @import("microzig");
const board = microzig.board;
const hal = microzig.hal;
const cpu = microzig.cpu;

// Taken from https://github.com/robinjanssens/WCH-Toolchain

pub fn main() !void {
    // Board brings up clocks and time
    board.init();

    const pins = board.pin_config.apply();
    const ws2812_pin = pins.ws2812;

    var i: u8 = 0;
    while (true) {
        const col: u32 = wheel(i);
        set_led(0, red(col), green(col), blue(col));
        write(ws2812_pin);
        hal.time.sleep_ms(33);
        // Allow overflow to wrap around
        i +%= 1;
    }
}

// Board has a single LED
const NUM_LEDS = 1;

fn color(r: u8, g: u8, b: u8) u32 {
    return (@as(u32, r) << 16) | (@as(u32, g) << 8) | b;
}

fn red(col: u32) u8 {
    return @truncate((col >> 16) & 0xFF);
}

fn green(col: u32) u8 {
    return @truncate((col >> 8) & 0xFF);
}

fn blue(col: u32) u8 {
    return @truncate(col & 0xFF);
}

fn wheel(wheel_pos: u8) u32 {
    var pos = 255 -% wheel_pos;
    if (pos < 85) {
        return color(255 -% pos *% 3, 0, pos *% 3);
    } else if (pos < 170) {
        pos -%= 85;
        return color(0, pos *% 3, 255 -% pos *% 3);
    } else {
        pos -%= 170;
        return color(pos *% 3, 255 -% pos *% 3, 0);
    }
}

var rgb_array: [3 * NUM_LEDS]u8 = undefined; // Each color is 3 bytes

inline fn nops(comptime n: usize) void {
    inline for (0..n) |_| asm volatile ("nop");
}

// Compact timing-accurate bit send using pin.put + NOP sequences
fn led_send_bit(pin: anytype, bit: u1) void {
    if (bit != 0) {
        // T1H ≈ 800 ns @ 48 MHz
        pin.put(1);
        nops(34);
        pin.put(0);
        // T1L ≈ 400Ns, taken up by other functions
        return;
    }
    // T0H ≈ 400 ns
    pin.put(1);
    nops(14);
    pin.put(0);
    // T0L ≈ 850 ns, 400 ns is taken up by other functions
    nops(20);
}

// Send a single color for a single LED
// WS2812B LEDs want 24 bits per led in the string
fn led_send_color(pin: anytype, r: u8, g: u8, b: u8) void {
    // Send the green component first (MSB)
    var i: i32 = 7;
    while (i >= 0) : (i -= 1) {
        led_send_bit(pin, @truncate((g >> @intCast(i)) & 1));
    }
    // Send the red component next
    i = 7;
    while (i >= 0) : (i -= 1) {
        led_send_bit(pin, @truncate((r >> @intCast(i)) & 1));
    }
    // Send the blue component last (LSB)
    i = 7;
    while (i >= 0) : (i -= 1) {
        led_send_bit(pin, @truncate((b >> @intCast(i)) & 1));
    }
}

fn write(pin: anytype) void {
    var i: usize = 0;
    while (i < NUM_LEDS) : (i += 1) {
        led_send_color(pin, rgb_array[i * 3], rgb_array[i * 3 + 1], rgb_array[i * 3 + 2]);
    }
    hal.time.sleep_ms(1);
}

fn set_led(i: usize, r: u8, g: u8, b: u8) void {
    rgb_array[i * 3] = r;
    rgb_array[i * 3 + 1] = g;
    rgb_array[i * 3 + 2] = b;
}
