const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const timer = microzig.hal.timer.GPTimer.init(.TIM2).into_counter_mode();

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);

const ADC = microzig.hal.adc.ADC;
const ADC_pin1 = gpio.Pin.from_port(.A, 1);
const ADC_pin2 = gpio.Pin.from_port(.A, 2);

const v25 = 1.43;
const avg_slope = 0.0043; //4.3mV/°C

fn adc_to_temp(val: usize) f32 {
    const temp_mv: f32 = (@as(f32, @floatFromInt(val)) / 4096) * 3.3; //convert to voltage
    return ((v25 - temp_mv) / avg_slope) + 25; //convert to celsius
}

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
};

pub fn main() !void {
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.AFIO);
    rcc.enable_clock(.USART1);
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.ADC1);
    const counter = timer.counter_device(rcc.get_clock(.TIM2));
    const adc = ADC.init(.ADC1);
    var adc_out_buf: [10]u16 = undefined;

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    ADC_pin1.set_input_mode(.analog);
    ADC_pin2.set_input_mode(.analog);

    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });

    stm32.uart.init_logger(&uart);

    adc.enable(&counter);
    adc.set_channel_sample_rate(16, .@"239.5");
    adc.set_channel_sample_rate(17, .@"239.5");
    adc.set_channel_sample_rate(1, .@"13.5");
    adc.set_channel_sample_rate(2, .@"13.5");
    adc.load_sequence(&.{ 16, 17, 1, 2 }); //CH16: CPU temp, CH17: Vref, CH1: ADC_pin1, CH2: ADC_pin2
    std.log.info("start ADC scan", .{});
    while (true) {
        const adc_buf: []const u16 = try adc.read_multiple_channels(&adc_out_buf);
        counter.sleep_ms(100);
        std.log.info("\x1B[2J\x1B[H", .{}); //Clear screen and move cursor to 1,1
        std.log.info("CPU temp: {d:.1}C", .{adc_to_temp(adc_buf[0])});
        std.log.info("Vref: {d:0>4}", .{adc_buf[1]});
        std.log.info("CH1: {d:0>4}", .{adc_buf[2]});
        std.log.info("CH2 {d}", .{adc_buf[3]});
    }
}
