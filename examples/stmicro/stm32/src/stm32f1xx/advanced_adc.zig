//example for the advanced ADC API, this API is recommended for those already familiar with the ADC of STM32s
//this example configures a regular group with software trigger, an injected group configured as auto injected,
//and an analog comparator (ADC watchdog)

//before creating a program using ADC from older ST families, such as in this case STM32F1
//be aware of possible hardware bugs and limitations
//for example:
// temperature sensor/VREF cannot be read in interleaved mode as it requires a sample time greater than 17
// readings after 1ms from the previous reading may contain more noise than expected
//Voltage glitch on ADC input 0

const std = @import("std");
const microzig = @import("microzig");
const interrupt = microzig.interrupt;

const RCC = microzig.chip.peripherals.RCC;
const DMA = microzig.chip.peripherals.DMA1;
const DMA_t = microzig.chip.types.peripherals.bdma_v1;
const stm32 = microzig.hal;
const timer = microzig.hal.timer.GPTimer.init(.TIM2).into_counter_mode();

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
    .interrupts = .{ .ADC1_2 = .{ .c = watchdog_handler } },
};

const AdvancedADC = microzig.hal.adc.AdvancedADC;
const adc = AdvancedADC.init(.ADC1);
const ADC_pin1 = gpio.Pin.from_port(.A, 1);
const ADC_pin2 = gpio.Pin.from_port(.A, 2);
const ADC_pin3 = gpio.Pin.from_port(.A, 3);

const v25 = 1.43;
const avg_slope = 0.0043; //4.3mV/°C

var ovf_flag: bool = false;
pub fn watchdog_handler() callconv(.C) void {
    ovf_flag = true;
    adc.clear_flags(adc.read_flags()); //clear all active flags
}

fn adc_to_temp(val: usize) f32 {
    const temp_mv: f32 = (@as(f32, @floatFromInt(val)) / 4096) * 3.3; //convert to voltage
    return ((v25 - temp_mv) / avg_slope) + 25; //convert to celsius
}

fn DMA_init(arr_addr: u32, adc_addr: u32) void {
    const CH1: *volatile DMA_t.CH = @ptrCast(&DMA.CH);
    CH1.CR.raw = 0; //disable channel
    CH1.NDTR.raw = 0;
    CH1.CR.modify(.{
        .DIR = DMA_t.DIR.FromPeripheral,
        .CIRC = 1, //disable circular mode
        .PL = DMA_t.PL.High, //high priority
        .MSIZE = DMA_t.SIZE.Bits16,
        .PSIZE = DMA_t.SIZE.Bits16,
        .MINC = 1, //memory increment mode
        .PINC = 0, //peripheral not incremented
    });

    CH1.NDTR.modify(.{ .NDT = 4 }); //number of data to transfer, 4 samples
    CH1.PAR = adc_addr; //peripheral address
    CH1.MAR = arr_addr; //memory address
    CH1.CR.modify(.{ .EN = 1 }); //enable channel
}

pub fn main() !void {
    RCC.AHBENR.modify(.{
        .DMA1EN = 1,
    });
    RCC.APB1ENR.modify(.{
        .TIM2EN = 1,
    });
    RCC.APB2ENR.modify(.{
        .AFIOEN = 1,
        .USART1EN = 1,
        .GPIOAEN = 1,
        .ADC1EN = 1,
    });

    const counter = timer.counter_device(8_000_000);

    const adc_data_addr: u32 = @intFromPtr(&adc.regs.DR);
    var adc_buf: [10]u16 = .{0} ** 10;
    const adc_buf_addr: u32 = @intFromPtr(&adc_buf);
    const ref_ovf_flag: *volatile bool = &ovf_flag;

    //configure UART log

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
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

    DMA_init(adc_buf_addr, adc_data_addr);

    while (true) {
        adc.software_trigger(); //start conversion
        counter.sleep_ms(100);
        std.log.info("\x1B[2J\x1B[H", .{}); // Clear screen and move cursor to 1,1
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
