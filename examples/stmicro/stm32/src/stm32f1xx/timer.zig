//basic example of using timers on STM32F1xx showing how to use high-level APIs for PWM and Counter.

const std = @import("std");
const microzig = @import("microzig");

//example usage
const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const GPTimer = stm32.timer.GPTimer;

//gpios
const ch1 = gpio.Pin.from_port(.A, 0);
const ch2 = gpio.Pin.from_port(.A, 1);
const ch3 = gpio.Pin.from_port(.A, 2);
const ch4 = gpio.Pin.from_port(.A, 3);

//timers
const pwm = GPTimer.init(.TIM2).into_pwm_mode();
const counter = GPTimer.init(.TIM3).into_counter_mode();
pub fn main() !void {

    //first we need to enable the clocks for the GPIO and TIM peripherals

    //use HSE as system clock source, more stable than HSI
    try rcc.clock_init(.{ .SysClkSource = .RCC_SYSCLKSOURCE_HSE });

    //enable GPIOA and TIM2, TIM3, AFIO clocks
    //AFIO is needed for alternate function remapping, not used in this example but eneble for easy remapping
    //if needed
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.TIM3);
    rcc.enable_clock(.AFIO);

    //counter device to genereate delays
    const cd = counter.counter_device(rcc.get_clock(.TIM3));

    //configure GPIO pins for PWM output
    for (&[_]gpio.Pin{ ch1, ch2, ch3, ch4 }) |pin| {
        pin.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    }

    //first we need to configure the PWM peripheral
    pwm.configure(.{
        .prescaler = 7, //prescaler value, 7 means pckl / 8
        .auto_reload = 1000, //1khz
        .counter_mode = .{ .up = {} },
    });

    //then we configure the channels

    //channel 0 is in fast mode and default polarity (active high)
    pwm.configure_channel(0, .{ .fast_mode = true });

    //channel 1 is in fast mode, active low polarity
    pwm.configure_channel(1, .{
        .fast_mode = true,
        .polarity = .low,
    });

    //channel 2 is in fast mode, inverted period
    pwm.configure_channel(2, .{
        .fast_mode = true,
        .invert = true,
    });

    //channel 3 is in fast mode, active low polarity and inverted period
    pwm.configure_channel(3, .{
        .fast_mode = true,
        .polarity = .low,
        .invert = true,
    });

    //channels need to be enbaled to start generating PWM signals
    for (0..4) |channel| {
        pwm.set_channel(@intCast(channel), true);
    }

    while (true) {
        //loop to change the duty cycle of all channels
        for (0..1000) |i| {
            pwm.set_duty(0, @intCast(i));
            pwm.set_duty(1, @intCast(i));
            pwm.set_duty(2, @intCast(i));
            pwm.set_duty(3, @intCast(i));

            //force update to apply the new duty cycle immediately, not obrigatory
            //but it is a good practice to force update after changing the duty cycle
            pwm.force_update();
            cd.sleep_ms(10); //wait for 10ms
        }
    }
}
