const microzig = @import("microzig");
const hal = microzig.hal;

const pwm_cool = hal.gpio.pin(.b, 0);
const pwm_warm = hal.gpio.pin(.b, 1);
const aux_led = hal.gpio.pin(.b, 5);
const switch_pin = hal.gpio.pin(.a, 5);
const Ramp = hal.progmem.Table(u8, 4, .{ 1, 4, 16, 64 });

pub fn main() void {
    hal.clock.useDefault20MHzDiv2();

    pwm_cool.set_direction(.output);
    pwm_warm.set_direction(.output);
    aux_led.set_direction(.output);
    hal.pcint.configure(switch_pin, true, .both_edges);

    hal.tca0.configurePwm(.{
        .top = 255,
        .compare0 = 48,
        .compare1 = 96,
        .enable_compare0 = true,
        .enable_compare1 = true,
        .waveform = .dual_slope_bottom,
        .clock = .div1,
    });

    hal.rtc_pit.configure(.cycles512, true);
    hal.adc.configure(.{
        .channel = .internal_reference,
        .reference = .vdd,
        .sample_count = .samples4,
        .prescaler = .div16,
        .initial_delay = .cycles16,
        .sample_capacitance = true,
        .freerun = true,
        .run_standby = true,
    });
    hal.adc.enableResultReadyInterrupt();
    hal.adc.start();
    hal.watchdog.reset();

    const saved_level = hal.eeprom.readByte(.fromInt(0));
    const ramp_level = Ramp.get(1);
    _ = saved_level;
    _ = ramp_level;

    while (true) {
        nop();
    }
}

inline fn nop() void {
    asm volatile ("nop");
}
