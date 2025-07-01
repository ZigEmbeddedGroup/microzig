//this example is an extension of advanced_adc.zig
//here it shows how to configure and use the Dual ADC mode using the advanced ADC API

const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const DMA = microzig.chip.peripherals.DMA1;
const DMA_t = microzig.chip.types.peripherals.bdma_v1;
const stm32 = microzig.hal;
const timer = microzig.hal.timer.GPTimer.init(.TIM2).into_counter_mode();

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);

const AdvancedADC = microzig.hal.adc.AdvancedADC;
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

fn DMA_init(arr_addr: u32, adc_addr: u32) void {
    const CH1: *volatile DMA_t.CH = @ptrCast(&DMA.CH);
    CH1.CR.raw = 0; //disable channel
    CH1.NDTR.raw = 0;
    CH1.CR.modify(.{
        .DIR = DMA_t.DIR.FromPeripheral,
        .CIRC = 1, //disable circular mode
        .PL = DMA_t.PL.High, //high priority
        .MSIZE = DMA_t.SIZE.Bits32,
        .PSIZE = DMA_t.SIZE.Bits32,
        .MINC = 1, //memory increment mode
        .PINC = 0, //peripheral not incremented
    });

    CH1.NDTR.modify(.{ .NDT = 2 }); //number of data to transfer, 2 samples
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
        .ADC2EN = 1,
    });
    const counter = timer.counter_device(8_000_000);
    const adc1 = AdvancedADC.init(.ADC1);
    const adc2 = AdvancedADC.init(.ADC2);

    const adc_data_addr: u32 = @intFromPtr(&adc1.regs.DR);
    var adc_buf: [2]AdcData = undefined;
    const adc_buf_addr: u32 = @intFromPtr(&adc_buf[0]);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    ADC_pin1.set_input_mode(.analog);
    ADC_pin2.set_input_mode(.analog);

    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
    });

    stm32.uart.init_logger(&uart);

    adc1.enable(true, &counter);
    adc1.enable_reftemp(&counter);
    adc2.enable(false, &counter);

    try adc1.configure_dual_mode(.{ .Regular = .{
        .dma = true,
        .master_seq = &.{ 16, 17 },
        .slave_seq = &.{ 1, 2 },
        .rate_seq = &.{ .@"239.5", .@"239.5" },
        .trigger = .SWSTART,
        .mode = .{ .Continuous = {} },
    } });

    std.log.info("start Dual ADC scan", .{});
    DMA_init(adc_buf_addr, adc_data_addr);
    adc1.software_trigger(); //start conversion
    while (true) {
        counter.sleep_ms(250);
        const temp = adc_buf[0].adc1;
        const vref = adc_buf[1].adc1;
        const ch1 = adc_buf[0].adc2;
        const ch2 = adc_buf[1].adc2;
        std.log.info("\x1B[2J\x1B[H", .{}); // Clear screen and move cursor to 1,1
        std.log.info("CPU temp: {d:.1}C", .{adc_to_temp(temp)});
        std.log.info("Vref: {d}", .{vref});
        std.log.info("CH1: {d}", .{ch1});
        std.log.info("CH2 {d}", .{ch2});
    }
}
