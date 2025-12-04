const std = @import("std");
const microzig = @import("microzig");
const stm32 = microzig.hal;
const HTS221 = microzig.drivers.sensor.HTS221;

fn delay() void {
    var i: u32 = 0;
    while (i < 8_000_000) {
        microzig.cpu.nop();
        i += 1;
    }
}

pub const microzig_options: microzig.Options = .{
    .logFn = microzig.hal.uart.log,
};

pub noinline fn init() void {
    microzig.board.init();
    microzig.board.init_log();
}

pub noinline fn main() !void {
    _ = (stm32.pins.GlobalConfiguration{
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

    var i2c1 = stm32.i2c.I2CDevice.init(.I2C1);
    try i2c1.apply();
    var device = i2c1.as_device();

    var hts221 = HTS221.init(&device);
    try hts221.configure(.{
        .outputDataRate = .SevenHz,
        .humidityAverageSample = .Avg32,
        .temperatureAverageSample = .Avg16,
    });
    try hts221.turn_on();

    while (true) {
        delay();

        if (try hts221.temperature_ready()) {
            const temp = try hts221.read_temperature();

            std.log.info("Reading temp sensor {}°C", .{temp});
        }
    }
}
