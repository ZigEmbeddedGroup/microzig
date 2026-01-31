const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const time = hal.time;
const gpio = hal.gpio;

const RCC = microzig.chip.peripherals.RCC;
const AFIO = microzig.chip.peripherals.AFIO;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
};

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();

    // Enable peripheral clocks for USART2 and GPIOA
    RCC.APB2PCENR.modify(.{
        .IOPAEN = 1, // Enable GPIOA clock
        .AFIOEN = 1, // Enable AFIO clock
    });
    RCC.APB1PCENR.modify(.{
        .USART2EN = 1, // Enable USART2 clock
    });

    // Ensure USART2 is NOT remapped (default PA2/PA3, not PD5/PD6)
    AFIO.PCFR1.modify(.{ .USART2_RM = 0 });

    // Configure PA2 as alternate function push-pull for USART2 TX
    usart_tx_pin.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud
    usart.apply(.{ .baud_rate = 115200 });

    hal.usart.init_logger(usart);

    var i: u32 = 0;
    while (true) : (i += 1) {
        std.log.info("what {}", .{i});
        time.sleep_ms(1000);
    }
}
