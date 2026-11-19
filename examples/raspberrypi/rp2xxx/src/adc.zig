//! This example takes periodic samples of the temperature sensor and
//! prints it to the UART using the stdlib logging facility.
const std = @import("std");
const microzig = @import("microzig");
const common = @import("common.zig");

const rp2xxx = microzig.hal;
const adc = rp2xxx.adc;
const time = rp2xxx.time;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .logFn = common.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    common.init_logger();

    adc.apply(.{
        .temp_sensor_enabled = true,
    });

    while (true) : (time.sleep_ms(1000)) {
        const sample = adc.convert_one_shot_blocking(.temp_sensor) catch {
            std.log.err("conversion failed!", .{});
            continue;
        };

        std.log.info("temp value: {}", .{sample});
    }
}
