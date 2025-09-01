//example for the advanced ADC API, this API is recommended for those already familiar with the ADC of STM32s
//this example configures a regular group with software trigger, an injected group configured as auto injected,
//and an analog comparator (ADC watchdog)

//before creating a program using ADC from older ST families, such as in this case STM32F1
//be aware of possible hardware bugs and limitations
//for example:
//temperature sensor/VREF cannot be read in interleaved mode as it requires a sample time greater than 17
//readings after 1ms from the previous reading may contain more noise than expected
//Voltage glitch on ADC input 0

const std = @import("std");
const microzig = @import("microzig");
const interrupt = microzig.interrupt;
const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const dma = stm32.dma;
const AdvancedADC = stm32.adc.AdvancedADC;

const dma_controller = dma.DMAController.init(.DMA1);
const timer = stm32.timer.GPTimer.init(.TIM2).into_counter_mode();
const uart = stm32.uart.UART.init(.USART1);
const adc = AdvancedADC.init(.ADC1);

const TX = gpio.Pin.from_port(.A, 9);
const ADC_pin1 = gpio.Pin.from_port(.A, 1);
const ADC_pin2 = gpio.Pin.from_port(.A, 2);
const ADC_pin3 = gpio.Pin.from_port(.A, 3);

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
    .interrupts = .{ .ADC1_2 = .{ .c = watchdog_handler } },
};

const v25 = 1.43;
const avg_slope = 0.0043; //4.3mV/°C

var ovf_flag: bool = false;
pub fn watchdog_handler() callconv(.c) void {
    ovf_flag = true;
    adc.clear_flags(adc.read_flags()); //clear all active flags
}

fn adc_to_temp(val: usize) f32 {
    const temp_mv: f32 = (@as(f32, @floatFromInt(val)) / 4096) * 3.3; //convert to voltage
    return ((v25 - temp_mv) / avg_slope) + 25; //convert to celsius
}

pub fn main() !void {
    try rcc.apply_clock(.{ .ADCprescaler = .RCC_ADCPCLK2_DIV2 });

    rcc.enable_clock(.DMA1);
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.AFIO);
    rcc.enable_clock(.USART1);
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.ADC1);

    const counter = timer.counter_device(rcc.get_clock(.TIM2));
    const ref_ovf_flag: *volatile bool = &ovf_flag;
    var adc_buf: [10]u16 = .{0} ** 10;

    dma_controller.apply_channel(0, .{
        .circular_mode = true,
        .memory_increment = true,

        .direction = .FromPeripheral,
        .priority = .High,
        .memory_size = .Bits16,
        .peripheral_size = .Bits16,

        .transfer_count = 4,
        .periph_address = @intFromPtr(&adc.regs.DR),
        .mem_address = @intFromPtr(&adc_buf),
    });
    dma_controller.start_channel(0);

    //configure UART log

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });
    stm32.uart.init_logger(&uart);

    //configure adc
    interrupt.enable(.ADC1_2); //enalbe ADC1 interrupt
    ADC_pin1.set_input_mode(.analog);
    ADC_pin2.set_input_mode(.analog);
    ADC_pin3.set_input_mode(.analog);

    //enable ADC and VREF/tempsensor
    adc.enable(true, &counter);
    adc.enable_reftemp(&counter);

    //regular group configuration
    try adc.configure_regular(.{
        .dma = true,
        .trigger = .SWSTART,
        .mode = .{
            .Single = .{
                .seq = &.{ 16, 17, 2, 3 },
                .channels_conf = &.{
                    .{ .channel = 17, .sample_rate = .@"239.5" }, //Vrefint
                    .{ .channel = 16, .sample_rate = .@"239.5" }, //temperature sensor
                    .{ .channel = 1, .sample_rate = .@"13.5" }, //ADC1 channel 1
                    .{ .channel = 3, .sample_rate = .@"13.5" }, //ADC1 channel 2
                },
            },
        },
    });

    //injected group configuration, AUTO INJECTED mode starts right after the regular group and therefore does not require an external trigger
    try adc.configure_injected(.{
        .mode = .{
            .auto_injected = .{
                .seq = &.{1},
            },
        },
    });

    //despite the name, this is just an analog comparator
    adc.configure_watchdog(
        .{
            .guard_mode = .{ .single_injected = 1 },
            .interrupt = true,
            .high_treshold = 4095,
            .low_treshold = 800,
        },
    );

    std.log.info("start Advanced ADC scan", .{});
    while (true) {
        adc.software_trigger(); //start conversion
        counter.sleep_ms(100);
        std.log.info("\x1B[2J\x1B[H", .{}); //Clear screen and move cursor to 1,1
        std.log.info("CPU temp: {d:.1}C", .{adc_to_temp(adc_buf[0])});
        std.log.info("Vref: {d:0>4}", .{adc_buf[1]});
        std.log.info("CH1: {d:0>4}", .{adc_buf[2]});
        std.log.info("CH3 {d}", .{adc_buf[3]});
        if (ref_ovf_flag.*) {
            std.log.info("Injected: OVERFLOW", .{});
            ref_ovf_flag.* = false;
            continue;
        }
        std.log.info("Injected: {d}", .{adc.read_injected_data(0)});
    }
}
