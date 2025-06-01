const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;
const gpio = stm32.gpio;

const drivers = microzig.drivers;
const lcd_driver = drivers.display.hd44780;
const lcd = drivers.display.HD44780;
const PCF8574 = drivers.IO_expander.PCF8574;
const State = drivers.base.Digital_IO.State;

const timer = stm32.timer.GPTimer.init(.TIM2);

const I2c = stm32.i2c;
const I2C_Device = stm32.drivers.I2C_Device;

const uart = stm32.uart.UART.init(.USART1);
const TX = gpio.Pin.from_port(.A, 9);

const i2c = I2c.I2C.init(.I2C2);
const SCL = gpio.Pin.from_port(.B, 10);
const SDA = gpio.Pin.from_port(.B, 11);
const config = I2c.Config{
    .pclk = 8_000_000,
    .speed = 100_000,
    .mode = .standard,
};

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
};

var global_counter: stm32.drivers.CounterDevice = undefined;

const i2c_device = I2C_Device.init(i2c, I2c.Address.new(0x27), config, &global_counter, null);

pub fn delay_us(time_delay: u32) void {
    global_counter.sleep_us(time_delay);
}
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

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    //Set internal Pull-ups (not recommended for real applications)
    SCL.set_input_mode(.pull);
    SDA.set_input_mode(.pull);
    SCL.set_pull(.up);
    SDA.set_pull(.up);

    //Set SCL and SDA to alternate function open drain
    SCL.set_output_mode(.alternate_function_open_drain, .max_50MHz);
    SDA.set_output_mode(.alternate_function_open_drain, .max_50MHz);

    const counter = timer.into_counter(8_000_000);
    global_counter = counter;

    i2c.apply(config);

    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
    });

    stm32.uart.init_logger(&uart);
    var expander = PCF8574(.{}).init(i2c_device.datagram_device());
    const pins_config = lcd(.{}).pins_struct{
        .high_pins = .{
            expander.digital_IO(4),
            expander.digital_IO(5),
            expander.digital_IO(6),
            expander.digital_IO(7),
        },
        .BK = expander.digital_IO(3),
        .RS = expander.digital_IO(0),
        .EN1 = expander.digital_IO(2),
    };
    var my_lcd = lcd(.{}).init(
        pins_config,
        delay_us,
    );

    try my_lcd.init_device(.{});
    try my_lcd.set_backlight(1);
    try my_lcd.write("hello world - From Zig");
    try my_lcd.set_cursor(1, 0);
    try my_lcd.write("STM32F103 - I2C LCD");

    while (true) {
        try my_lcd.shift_display_left();
        global_counter.sleep_ms(300);
    }
}
