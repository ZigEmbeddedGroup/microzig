const std = @import("std");

const microzig = @import("microzig");
const hal = microzig.hal;
const rcc = hal.rcc;
const time = hal.time;
const uart = hal.uart.UART.init(.USART1);
const RX = hal.gpio.Pin.from_port(.A, 10);
const TX = hal.gpio.Pin.from_port(.A, 9);
const Duration = microzig.drivers.time.Duration;

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    _ = try rcc.apply(.{
        .SYSCLKSource = .PLL1_P,
        .HSEDivPLL = .Div1,
        .PLLSourceVirtual = .HSE_Div_PREDIV,
        .PLLMUL = .Mul9,
        .AHBCLKDivider = .Div1,
        .APB1CLKDivider = .Div2,
        .flags = .{
            .RTCUsed_ForRCC = true,
            .HSEOscillator = true,
        },
    });

    rcc.enable_clock(.GPIOC);
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.USART1);

    time.init_timer(.TIM2);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    RX.set_input_mode(.pull);

    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });

    var uart_writer = uart.writer(&.{});

    var byte: [100]u8 = undefined;

    //simple USART echo
    _ = try uart.write_blocking("START UART ECHO\n", null);
    while (true) {
        @memset(&byte, 0);
        const len = uart.read_blocking(&byte, Duration.from_ms(100)) catch |err| {
            if (err != error.Timeout) {
                uart_writer.intf.print("Got error {any}\n", .{err}) catch unreachable;
                uart.clear_errors();
            }
            continue;
        };

        _ = uart.write_blocking(byte[0..len], null) catch unreachable;
    }
}
