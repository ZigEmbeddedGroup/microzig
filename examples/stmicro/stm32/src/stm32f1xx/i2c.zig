const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;
const gpio = stm32.gpio;

const timer = stm32.timer.GPTimer.init(.TIM2);

const i2c = stm32.i2c;

const uart = stm32.uart.UART.init(.USART1);
const TX = gpio.Pin.from_port(.A, 9);

const i2c2 = i2c.I2C.init(.I2C2);
const SCL = gpio.Pin.from_port(.B, 10);
const SDA = gpio.Pin.from_port(.B, 11);
const ADDR = i2c.Address.new(0x27);
const config = i2c.Config{
    .pclk = 8_000_000,
    .speed = 100_000,
    .mode = .standard,
};

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.logFn,
};

pub fn main() !void {
    RCC.APB2ENR.modify(.{
        .GPIOBEN = 1,
        .GPIOAEN = 1,
        .AFIOEN = 1,
        .USART1EN = 1,
    });

    RCC.APB1ENR.modify(.{
        .I2C2EN = 1,
        .TIM2EN = 1,
    });

    const counter = timer.into_counter(8_000_000);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    //Set internal Pull-ups (not recommended for real applications)
    SCL.set_input_mode(.pull);
    SDA.set_input_mode(.pull);
    SCL.set_pull(.up);
    SDA.set_pull(.up);

    //Set SCL and SDA to alternate function open drain
    SCL.set_output_mode(.alternate_function_open_drain, .max_50MHz);
    SDA.set_output_mode(.alternate_function_open_drain, .max_50MHz);

    i2c2.apply(config);

    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
    });

    stm32.uart.init_logger(&uart);

    var to_read: [1]u8 = undefined;
    std.log.info("start I2C master", .{});
    while (true) {
        for (0..0xFF) |val| {
            std.log.info("sending {d}", .{val});
            i2c2.write_blocking(ADDR, &.{@intCast(val)}, counter.make_ms_timeout(5000)) catch |err| {
                std.log.err("send to send data | error {any}", .{err});
                if (err == error.UnrecoverableError) {
                    //Reset I2C peripheral
                    i2c2.apply(config);
                } else {
                    i2c2.clear_errors();
                }
                continue;
            };

            std.log.info("receiving data from the slave", .{});
            i2c2.read_blocking(ADDR, &to_read, counter.make_ms_timeout(1000)) catch |err| {
                std.log.err("fail to read data | error {any}", .{err});
                if (err == error.UnrecoverableError) {
                    //Reset I2C peripheral
                    i2c2.apply(config);
                } else {
                    i2c2.clear_errors();
                }
                continue;
            };
            std.log.info("data received: {}", .{to_read[0]});
            counter.sleep_ms(1000);
        }
    }
}
