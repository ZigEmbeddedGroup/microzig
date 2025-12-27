const std = @import("std");
const microzig = @import("microzig");
const stm32 = microzig.hal;
const systick = stm32.systick;
const board = microzig.board;
const HTS221 = microzig.drivers.sensor.HTS221;

pub const microzig_options: microzig.Options = .{
    .logFn = microzig.board.uart_logger.log,
    .interrupts = .{
        .SysTick = .{ .c = systick.SysTick_handler },
    },
};

pub fn init() void {
    board.init();
    board.init_log();
    systick.init() catch {
        @panic("systick failed to initialized");
    };
}

pub fn main() !void {
    const clock = try stm32.systick_timer.clock_device();
    var i2c1 = board.i2c1();
    try i2c1.apply();
    var device = i2c1.i2c_device();

    var hts221 = HTS221.init(&device);
    try hts221.configure(.{
        .outputDataRate = .SevenHz,
        .humidityAverageSample = .Avg32,
        .temperatureAverageSample = .Avg16,
    });
    try hts221.turn_on();

    while (true) {
        clock.sleep_ms(2_000);

        if (try hts221.temperature_ready()) {
            const temp = try hts221.read_temperature();

            std.log.info("Reading temperature {d:.2}°C", .{temp});
        }
        if (try hts221.humidity_ready()) {
            const humidity = try hts221.read_humidity();

            std.log.info("Reading relative humidity {d:.2}%", .{humidity});
        }
    }
}
