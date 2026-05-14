const microzig = @import("microzig");
const hal = microzig.hal;

const ch1_pwm = hal.gpio.pin(.b, 3);
const ch2_pwm = hal.gpio.pin(.a, 6);
const fet_pwm = hal.gpio.pin(.c, 0);
const voltage = hal.gpio.pin(.b, 1);
const Gamma = hal.progmem.Table(u8, 4, .{ 0, 8, 32, 255 });

pub fn main() void {
    ch1_pwm.set_direction(.output);
    ch2_pwm.set_direction(.output);
    fet_pwm.set_direction(.output);
    voltage.set_direction(.input);

    hal.timer1.configure_phase_correct_dynamic(.{ .top = 255, .prescaler = .clk_1 });
    hal.timer1.set_compare_a(96);
    hal.timer1.set_compare_b(64);

    hal.timer0.configure_phase_correct_pwm_a(.clk_1);
    hal.timer0.set_compare_a(32);

    hal.adc.configure_internal1v1(.adc6, .div64);
    hal.adc.start();
    hal.watchdog.reset();
    hal.watchdog.configure(.interrupt, .ms16);

    const saved_level = hal.eeprom.read_byte(hal.eeprom.address(0));
    const gamma_level = Gamma.get(2);
    _ = saved_level;
    _ = gamma_level;

    while (true) {
        nop();
    }
}

inline fn nop() void {
    asm volatile ("nop");
}
