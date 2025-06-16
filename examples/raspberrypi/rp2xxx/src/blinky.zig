const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;

pub const microzig_options: microzig.Options = .{
    .cpu = if (rp2xxx.compatibility.arch == .arm) .{
        .ram_vector_table = true,
    } else .{},
};

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO0 = .{
        .name = "led",
        .direction = .out,
    },
};

const pins = pin_config.pins();

fn hello() callconv(.c) void {

}

pub fn main() !void {
    if (rp2xxx.compatibility.arch == .arm) {
        microzig.cpu.ram_vector_table.SysTick = .{ .c = hello };
    }
    pin_config.apply();

    while (true) {
        pins.led.toggle();
        time.sleep_ms(250);
    }
}
