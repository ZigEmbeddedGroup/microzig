const microzig = @import("microzig");
const hal = microzig.hal;
//TODO: expose RGB Led pins as PWM

const Color = enum(u3) {
    // RGB LED is active-low
    off = 0b111,
    blue = 0b110,
    green = 0b101,
    cyan = 0b100,
    red = 0b011,
    magenta = 0b010,
    yellow = 0b001,
    white = 0b000,
};

const RGB_Pin = packed struct(u3) {
    B: u1,
    G: u1,
    R: u1,
};

//expose the RGB led pins as GPIOs
pub const Digital_RGB_Led = struct {
    const port3 = hal.port.num(3);
    const R = hal.gpio.from_pin(.P3_12);
    const G = hal.gpio.from_pin(.P3_13);
    const B = hal.gpio.from_pin(.P3_0);

    pub fn init() void {
        port3.init();
        R.init();
        R.set_direction(.out);
        G.set_direction(.out);
        B.set_direction(.out);
    }

    pub fn set_color(c: Color) void {
        const P: RGB_Pin = @bitCast(c);

        R.put(P.R);
        G.put(P.G);
        B.put(P.B);
    }
};
