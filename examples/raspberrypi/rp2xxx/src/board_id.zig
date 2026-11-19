const std = @import("std");
const microzig = @import("microzig");
const common = @import("common.zig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = common.log,
});

pub const panic = microzig.panic;

comptime {
    _ = microzig.export_startup();
}

const log = std.log.scoped(.main);

pub fn main() !void {
    common.init_logger();

    const chip_id = rp2xxx.get_chip_id();
    log.info("chip id: part={t} revision={d} manufacturer={t} stop_bit={}", .{
        chip_id.part,
        chip_id.revision,
        chip_id.manufacturer,
        chip_id.stop_bit,
    });

    while (true) {
        log.info("unique board id: {x}", .{rp2xxx.get_board_id()});
        time.sleep_ms(1000);
    }
}
