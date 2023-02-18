const std = @import("std");
const microzig = @import("../deps/microzig/src/main.zig");
const Board = microzig.Board;

const chips = @import("chips.zig");

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

const root_path = root() ++ "/";

pub const stm32f3discovery = Board{
    .name = "STM32F3DISCOVERY",
    .source = .{ .path = root_path ++ "boards/STM32F3DISCOVERY.zig" },
    .chip = chips.stm32f303vc,
};

pub const stm32f4discovery = Board{
    .name = "STM32F4DISCOVERY",
    .source = .{ .path = root_path ++ "boards/STM32F4DISCOVERY.zig" },
    .chip = chips.stm32f407vg,
};

pub const stm3240geval = Board{
    .name = "STM3240G_EVAL",
    .source = .{ .path = root_path ++ "boards/STM3240G_EVAL.zig" },
    .chip = chips.stm32f407vg,
};

pub const stm32f429idiscovery = Board{
    .name = "STM32F429IDISCOVERY",
    .source = .{ .path = root_path ++ "boards/STM32F429IDISCOVERY.zig" },
    .chip = chips.stm32f429zit6u,
};
