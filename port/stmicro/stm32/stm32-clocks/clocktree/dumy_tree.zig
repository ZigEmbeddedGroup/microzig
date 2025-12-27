const std = @import("std");

const clock = @import("nodes/ClockNode.zig");
const comptime_fail_or_error = clock.comptime_fail_or_error;

pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    _ = mcu_data;
    return struct {
        pub const Config = struct {};
        pub const Clock_Output = struct {};
        pub const Config_Output = struct {};

        pub const Tree_Output = struct {
            clock: Clock_Output,
            config: Config_Output,
        };

        pub fn get_clocks(_: Config) anyerror!Tree_Output {
            comptime_fail_or_error(error.InvalidTree,
                \\The selected MCU does not have a valid clock tree at the moment.
                \\Once the clock tree is valid, you can replace dummy_tree.zig with the correct tree.
            , .{});
        }
    };
}
