const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;

const timer = stm32.timer.GPTimer.init(.TIM2).into_counter_mode();

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
    .logFn = stm32.uart.log,
};

pub fn main() !void {
    rcc.enable_clock(.GPIOB);
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.USART1);
    rcc.enable_clock(.I2C2);
    rcc.enable_clock(.TIM2);

    const counter = timer.counter_device(rcc.get_clock(.TIM2));

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

    try uart.apply_runtime(.{
        .baud_rate = 115200,
        .clock_speed = rcc.get_clock(.USART1),
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
