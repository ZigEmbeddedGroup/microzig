const microzig = @import("microzig");
const std = @import("std");
const pins = microzig.hal.pins;
const RCC = microzig.chip.peripherals.RCC;
const mcu_name = @typeName(microzig.chip);

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    if (comptime std.mem.find(u8, mcu_name, "CH32V00")) |_| {
        // To output a clock, PC4 must be set to `OutputMode.alternate_function_push_pull`
        const pin_config = pins.GlobalConfiguration{
            .GPIOC = .{
                .PIN4 = .{
                    .name = "mco",
                    .mode = .{ .output = .alternate_function_push_pull },
                },
            },
        };
        _ = pin_config.apply();

        // Output SYSCLK to PC4. Note: the selected pin is not configurable.
        // [CH32V00X Reference Manual - 3.3.5.4 Microcontroller Clock Output (MCO)]
        RCC.CFGR0.modify(.{
            .MCO = 0b100,
        });
    }

    asm volatile ("nop");
    // while (true) {
    //     asm volatile ("" ::: "memory");
    // }
}
