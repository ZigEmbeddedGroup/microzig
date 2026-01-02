//NOTE: this is an advanced example and is recommended for those who already have experience with the STM32F1
//Example to demonstrate the use of input capture on STM32F1xx
//in this example an operation called PWM input is performed
//where two channels read the same input but are triggered on different edges
//thus measuring the frequency and duty cycle of a PWM signal

const std = @import("std");
const microzig = @import("microzig");

//example usage
const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const GPTimer = stm32.timer.GPTimer;
const time = stm32.time;

//gpios
const ch1 = gpio.Pin.from_port(.A, 0);

const uart = stm32.uart.UART.init(.USART1);
const TX = gpio.Pin.from_port(.A, 9);

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
    .interrupts = .{ .TIM2 = .{ .c = isr_tim2 } },
    .overwrite_hal_interrupts = true,
};

const comp = GPTimer.init(.TIM2);

var global_uptime: i32 = 0;
var global_downtime: i32 = 0;
var global_dif: u32 = 0;

var freq: i32 = 0;
var duty_cycle: f32 = 0;

//function that handles timer interrupts
//since the timer is reset at each rising edge,
//the value of ch2 marks the moment when the signal went from high to low, indicating the duty cycle.
//the value of ch1 marks the point when the signal goes back to high before the timer resets, indicating the period.
fn isr_tim2() callconv(.c) void {
    const flags = comp.get_interrupt_flags();
    if (flags.channel2) {
        const rev_ch1 = comp.read_ccr(0);
        const rev_fch1: f32 = @floatFromInt(rev_ch1);
        const rev_ch2 = comp.read_ccr(1);
        const rev_fch2: f32 = @floatFromInt(rev_ch2);

        global_uptime = rev_ch1;
        global_downtime = rev_ch2;

        global_dif = @intCast(@abs(global_uptime - global_downtime));
        freq = @divFloor(1_000_000, global_uptime);

        duty_cycle = (rev_fch2 / rev_fch1) * 100;
    }

    comp.clear_interrupts();
}

//timers
pub fn main() !void {

    //first we need to enable the clocks for the GPIO and TIM peripherals

    //use HSE as system clock source, more stable than HSI
    _ = try rcc.apply(.{
        .SYSCLKSource = .RCC_SYSCLKSOURCE_HSE,
        .flags = .{ .HSEOscillator = true },
    });

    //enable GPIOA and TIM2, TIM3, AFIO clocks
    //AFIO is needed for alternate function remapping, not used in this example but eneble for easy remapping
    //if needed
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.TIM3);
    rcc.enable_clock(.AFIO);
    rcc.enable_clock(.USART1);

    time.init_timer(.TIM3);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });

    stm32.uart.init_logger(&uart);

    //set PA0 (TI1) to input
    ch1.set_input_mode(.floating);

    //configure the timer for a frequency of 1MHz counting upwards
    //enable sync mode to reset the counter on the rising edge of TI1 (after filtering)
    //filter only can be configured by channel 1 (index 0)
    comp.timer_general_config(.{
        .prescaler = 7,
        .counter_mode = .{ .up = {} },
        .sync_config = .{
            .trigger_source = .TI1FP1,
            .mode = .ResetMode,
        },
    });
    comp.start();

    //configure channel 1 and 2 for the same input (TI1) with inverted edges between them
    comp.configure_ccr(0, .{
        .ch_mode = .{ .capture = .{} },
    });

    comp.configure_ccr(1, .{
        .ch_mode = .{ .capture = .{ .mode = .input_alternate } },
        .polarity = .low,
        .channel_interrupt_enable = true,
    });

    //enable timer channels and interrupts
    comp.set_channel(0, true);
    comp.set_channel(1, true);
    comp.set_interrupt(true);
    microzig.interrupt.enable_interrupts();
    microzig.interrupt.enable(.TIM2);

    while (true) {
        //values are received in the timer interrupt
        std.log.info("uptime: {d}", .{global_uptime});
        std.log.info("downtime: {d}", .{global_downtime});
        std.log.info("freq: {d}HZ", .{freq});
        std.log.info("duty: {d:.2}%", .{duty_cycle});

        time.sleep_ms(1350);
    }
}
