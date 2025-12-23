const std = @import("std");

pub fn find_clock_tree(comptime name: []const u8) type {
    const F103 = @import("clocks/clock_stm32f103.zig");
    //ALL F1 peri
    const F105_7 = @import("clocks/clock_stm32f105.zig");

    if (std.mem.indexOf(u8, name, "105")) |_| return F105_7;
    if (std.mem.indexOf(u8, name, "107")) |_| return F105_7;
    return F103;
}
