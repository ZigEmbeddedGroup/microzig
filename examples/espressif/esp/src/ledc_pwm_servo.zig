const std = @import("std");
const microzig = @import("microzig");
const esp = microzig.hal;

const pwm_pin = esp.gpio.num(0);
const ledc_timer = esp.ledc.timer(0);
const ledc_channel = esp.ledc.channel(0);

const PWM_FREQ_HZ = 50;
const PWM_PERIOD_MS = 1000 / PWM_FREQ_HZ;
const PWM_PRECISION_BITS = 14;
const PWM_MAX_DUTY = std.math.pow(u32, 2, PWM_PRECISION_BITS) - 1;

const PWM_MIN_LEVEL: u16 = @intFromFloat(@trunc(@as(f32, 1.0) / PWM_PERIOD_MS * PWM_MAX_DUTY));
const PWM_MAX_LEVEL: u16 = @intFromFloat(@trunc(@as(f32, 2.0) / PWM_PERIOD_MS * PWM_MAX_DUTY));

pub fn main() !void {
    // pwm servo driver

    pwm_pin.apply(.{ .output_enable = true });
    ledc_channel.connect_pin(pwm_pin);

    esp.ledc.apply(.apb_clk);
    ledc_timer.apply(.{
        .clock_config = esp.clock_config,
        .frequency = 50,
        .precision = 14,
    }, .apb_clk);

    ledc_channel.apply(.{
        .timer = ledc_timer,
        .initial_duty = PWM_MIN_LEVEL,
    });

    while (true) {
        ledc_channel.set_duty(PWM_MAX_LEVEL);
        esp.time.sleep_ms(1000);
        ledc_channel.set_duty(PWM_MIN_LEVEL);
        esp.time.sleep_ms(1000);
    }
}
