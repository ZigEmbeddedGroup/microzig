const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const DMA = microzig.chip.peripherals.DMA1;
const DMA_t = microzig.chip.types.peripherals.bdma_v1;
const stm32 = microzig.hal;
const timer = microzig.hal.timer.GPTimer.init(.TIM2);

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);

const AdvancedADC = microzig.hal.adc.AdvancedADC;
const ADC_pin1 = gpio.Pin.from_port(.A, 1);
const ADC_pin2 = gpio.Pin.from_port(.A, 2);
const ADC_pin3 = gpio.Pin.from_port(.A, 3);

const v25 = 1.43;
const avg_slope = 0.0043; //4.3mV/°C

fn adc_to_temp(val: usize) f32 {
    const temp_mv: f32 = (@as(f32, @floatFromInt(val)) / 4096) * 3.3; //convert to voltage
    return ((v25 - temp_mv) / avg_slope) + 25; //convert to celsius
}

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
};

fn DMA_init(arr_addr: u32, adc_addr: u32) void {
    const CH1: *volatile DMA_t.CH = @ptrCast(&DMA.CH);
    CH1.CR.modify(.{ .EN = 0 }); //disable channel
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
        .ADC2EN = 1,
    });
    const counter = timer.into_counter(8_000_000);
    const adc1 = AdvancedADC.init(.ADC1);
    const adc2 = AdvancedADC.init(.ADC2);

    //const adc_data_addr: u32 = @intFromPtr(&adc.regs.DR);
    //var adc_buf: [10]u16 = undefined;
    //const adc_buf_addr: u32 = @intFromPtr(&adc_buf);

    //DMA_init(adc_buf_addr, adc_data_addr);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    ADC_pin1.set_input_mode(.analog);
    ADC_pin2.set_input_mode(.analog);
    ADC_pin3.set_input_mode(.analog);

    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
    });

    stm32.uart.init_logger(&uart);

    adc1.enable(true, &counter);
    adc1.enable_refint(&counter);
    adc2.enable(true, &counter);

    try adc1.set_dual_mode(.{
        .injected_simultaneous = .{
            .master_seq = &.{ 16, 17 },
            .slave_seq = &.{ 1, 2 },
            .rate_seq = &.{ .@"239.5", .@"239.5" },
        },
    });

    std.log.info("start Advanced ADC scan", .{});
    while (true) {
        adc1.software_injected_trigger(); //start conversion
        counter.sleep_ms(100);
        std.log.info("\x1B[2J\x1B[H", .{}); // Clear screen and move cursor to 1,1
        std.log.info("CPU temp: {d:.1}C", .{adc_to_temp(@intCast(adc1.read_injected_data(0)))});
        std.log.info("Vref: {d}", .{adc1.read_injected_data(1)});
        std.log.info("CH1: {d}", .{adc2.read_injected_data(0)});
        std.log.info("CH2 {d}", .{adc2.read_injected_data(1)});
    }
}
