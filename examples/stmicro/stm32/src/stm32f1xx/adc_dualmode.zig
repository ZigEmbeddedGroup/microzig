//this example is an extension of advanced_adc.zig
//here it shows how to configure and use the Dual ADC mode using the advanced ADC API

const std = @import("std");

const microzig = @import("microzig");
const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const dma = stm32.dma;
const AdvancedADC = stm32.adc.AdvancedADC;
const time = stm32.time;

const dma_controller = dma.DMAController.init(.DMA1);
const uart = stm32.uart.UART.init(.USART1);

const TX = gpio.Pin.from_port(.A, 9);
const ADC_pin1 = gpio.Pin.from_port(.A, 1);
const ADC_pin2 = gpio.Pin.from_port(.A, 2);

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
};

const AdcData = packed struct(u32) {
    adc1: u16,
    adc2: u16,
};

const v25 = 1.43;
const avg_slope = 0.0043; //4.3mV/°C

fn adc_to_temp(val: usize) f32 {
    const temp_mv: f32 = (@as(f32, @floatFromInt(val)) / 4096) * 3.3; //convert to voltage
    return ((v25 - temp_mv) / avg_slope) + 25; //convert to celsius
}

pub fn main() !void {
    rcc.enable_clock(.DMA1);
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.AFIO);
    rcc.enable_clock(.USART1);
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.ADC1);
    rcc.enable_clock(.ADC2);
    time.init_timer(.TIM2);

    const adc1 = AdvancedADC.init(.ADC1);
    const adc2 = AdvancedADC.init(.ADC2);
    var adc_buf: [2]AdcData = undefined;

    dma_controller.apply_channel(0, .{
        .circular_mode = true,
        .memory_increment = true,

        .direction = .FromPeripheral,
        .priority = .High,
        .memory_size = .Bits32,
        .peripheral_size = .Bits32,

        .transfer_count = 2,
        .periph_address = @intFromPtr(&adc1.regs.DR),
        .mem_address = @intFromPtr(&adc_buf),
    });
    dma_controller.start_channel(0);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    ADC_pin1.set_input_mode(.analog);
    ADC_pin2.set_input_mode(.analog);

    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });

    stm32.uart.init_logger(&uart);

    adc1.enable(true);
    adc1.enable_reftemp();
    adc2.enable(true);

    try adc1.configure_dual_mode(.{ .Regular = .{
        .dma = true,
        .primary_seq = &.{ 16, 17 },
        .secondary_seq = &.{ 1, 2 },
        .rate_seq = &.{ .@"239.5", .@"239.5" },
        .trigger = .SWSTART,
        .mode = .{ .Continuous = {} },
    } });

    std.log.info("start Dual ADC scan", .{});
    adc1.software_trigger(); //start conversion
    while (true) {
        time.sleep_ms(250);
        const temp = adc_buf[0].adc1;
        const vref = adc_buf[1].adc1;
        const ch1 = adc_buf[0].adc2;
        const ch2 = adc_buf[1].adc2;
        std.log.info("\x1B[2J\x1B[H", .{}); //Clear screen and move cursor to 1,1
        std.log.info("CPU temp: {d:.1}C", .{adc_to_temp(temp)});
        std.log.info("Vref: {d}", .{vref});
        std.log.info("CH1: {d}", .{ch1});
        std.log.info("CH2 {d}", .{ch2});
    }
}
