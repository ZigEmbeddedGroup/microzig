const std = @import("std");

pub const microzig = @import("microzig");

pub const hal = microzig.hal;
pub const rcc = hal.rcc;

pub const uart_logger = hal.uart.UARTLogger(.USART1);

pub const leds_config = (hal.pins.GlobalConfiguration{
    .GPIOE = .{
        .PIN8 = .{ .name = "LD4", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN9 = .{ .name = "LD3", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN10 = .{ .name = "LD5", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN11 = .{ .name = "LD7", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN12 = .{ .name = "LD9", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN13 = .{ .name = "LD10", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN14 = .{ .name = "LD8", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN15 = .{ .name = "LD6", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
    },
});

pub fn init() void {
    rcc.enable_hse(8_000_000);
    rcc.enable_pll(.HSE, .Div1, .Mul5) catch {
        @panic("PLL faile to enable");
    };
    rcc.select_pll_for_sysclk() catch {
        @panic("Faile to select sysclk");
    };
}

// Init should come first or the baud_rate would be too fast for the default HSI.
pub fn init_log() void {
    _ = (hal.pins.GlobalConfiguration{
        .GPIOC = .{
            .PIN4 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
            .PIN5 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
        },
    }).apply();
    uart_logger.init_logger(.{ .baud_rate = 115200 });
}

pub fn i2c1() hal.i2c.I2C_Device {
    _ = (hal.pins.GlobalConfiguration{
        .GPIOB = .{
            // I2C
            .PIN6 = .{ .mode = .{ .alternate_function = .{
                .afr = .AF4,
            } } },
            .PIN7 = .{ .mode = .{ .alternate_function = .{
                .afr = .AF4,
            } } },
        },
    }).apply();

    return hal.i2c.I2C_Device.init(.I2C1);
}
