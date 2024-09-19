const std = @import("std");
const MicroZig = @import("microzig/build");

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();
const register_definition_path = build_root ++ "/chips/all.zig";

pub const STM32C011D6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C011D6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C011F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C011F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C011F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C011F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C011J4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C011J4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C011J6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C011J6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031C4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031G4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031G4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031K4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32C031K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32C031K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F030C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F030C6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F030C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F030C8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F030CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F030CC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F030F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F030F4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F030K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F030K6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F030R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F030R8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F030RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F030RC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031C4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031C6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031E6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031E6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031F4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031F6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031G4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031G4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031G6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031K4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F031K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F031K6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F038C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F038C6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F038E6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F038E6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F038F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F038F6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F038G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F038G6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F038K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F038K6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042C4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042C6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042F4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042F6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042G4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042G4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042G6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042K4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042K6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F042T6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F042T6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F048C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F048C6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F048G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F048G6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F048T6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F048T6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051C4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051C6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051C8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051K4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051K6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051K8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051R4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051R4",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051R6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051R8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F051T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F051T8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F058C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F058C8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F058R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F058R8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F058T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F058T8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F070C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F070C6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F070CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F070CB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F070F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F070F6",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F070RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F070RB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F071C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F071C8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F071CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F071CB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F071RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F071RB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F071V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F071V8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F071VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F071VB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F072C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F072C8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F072CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F072CB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F072R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F072R8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F072RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F072RB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F072V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F072V8",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F072VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F072VB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F078CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F078CB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F078RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F078RB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F078VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F078VB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F091CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F091CB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F091CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F091CC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F091RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F091RB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F091RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F091RC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F091VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F091VB",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F091VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F091VC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F098CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F098CC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F098RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F098RC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F098VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F098VC",
        .cpu = MicroZig.cpus.cortex_m0,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100C4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100C6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100C8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100CB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100R4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100R4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100R6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100RD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100V8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100VD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100ZD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F100ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F100ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101C4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101C6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101C8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101CB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101R4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101R4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101R6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101RD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101RF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101RF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101RG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101T4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101T4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101T6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101T6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101T8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101TB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101TB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101V8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101VD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101VF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101VF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101VG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101ZD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101ZF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101ZF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F101ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F101ZG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102C4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102C6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102C8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102CB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102R4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102R4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102R6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F102RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F102RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F103C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103C4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103C6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103C8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103CB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103R4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103R4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103R6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103RD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103RF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103RF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103RG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103T4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103T4",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103T6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103T6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103T8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103TB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103TB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103V8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103VD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103VF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103VF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103VG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103ZD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103ZF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103ZF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F103ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F103ZG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
    .hal = .{
        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
    },
};

pub const STM32F105R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F105R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F105RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F105RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F105RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F105RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F105V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F105V8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F105VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F105VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F105VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F105VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F107RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F107RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F107RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F107RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F107VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F107VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F107VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F107VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205RF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205RF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xA0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205RG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205VF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205VF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xA0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205VG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205ZF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205ZF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xA0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F205ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F205ZG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207IC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207IC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207IE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207IF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207IF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xA0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207IG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207VF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207VF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xA0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207VG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207ZF = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207ZF",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xA0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F207ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F207ZG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F215RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F215RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F215RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F215RG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F215VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F215VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F215VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F215VG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F215ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F215ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F215ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F215ZG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F217IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F217IE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F217IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F217IG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F217VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F217VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F217VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F217VG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F217ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F217ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F217ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F217ZG",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F301C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F301C6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F301C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F301C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F301K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F301K6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F301K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F301K8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F301R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F301R6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F301R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F301R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302C6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302K6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302K8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302R6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302RD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302VD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302ZD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F302ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F302ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303C6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303K6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303K8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303R6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303RD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303VD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303ZD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F303ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F303ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F318C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F318C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F318K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F318K8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F328C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F328C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334C4",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334C6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334K4",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334K6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334K8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334R6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F334R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F334R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F358CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F358CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F358RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F358RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F358VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F358VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373V8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F373VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F373VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F378CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F378CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F378RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F378RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F378VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F378VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F398VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F398VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401CD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401CD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401RD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401VD",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F401VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F401VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F405OE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F405OE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F405OG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F405OG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F405RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F405RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F405VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F405VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F405ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F405ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F407IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F407IE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F407IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F407IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F407VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F407VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F407VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F407VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F407ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F407ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F407ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F407ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x1C000, .kind = .ram },
            .{ .offset = 0x2001C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F410C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F410C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F410CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F410CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F410R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F410R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F410RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F410RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F410T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F410T8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F410TB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F410TB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F411CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F411CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F411CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F411CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F411RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F411RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F411RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F411RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F411VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F411VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F411VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F411VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412CG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F412ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F412ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413CG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413CH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413CH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413MG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413MG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413MH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413MH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413RH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413RH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413VH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413VH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F413ZH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F413ZH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F415OG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F415OG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F415RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F415RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F415VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F415VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F415ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F415ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F417IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F417IE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F417IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F417IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F417VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F417VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F417VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F417VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F417ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F417ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F417ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F417ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F423CH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F423CH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F423MH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F423MH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F423RH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F423RH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F423VH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F423VH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F423ZH = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F423ZH",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x160000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427II",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F427ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F427ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429BE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429BE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429BG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429BI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429IE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429II",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429NE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429NE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429NG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429NI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F429ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F429ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F437AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F437AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F437IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F437IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F437II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F437II",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F437VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F437VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F437VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F437VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F437ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F437ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F437ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F437ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439BG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439BI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439II",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439NG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439NI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F439ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F439ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446MC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446ZC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F446ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F446ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469AE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469AE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469BE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469BE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469BG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469BI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469IE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469II",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469NE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469NE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469NG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469NI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F469ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F469ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479BG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479BI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479IG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479II",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479NG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479NI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F479ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F479ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8110000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8120000, .length = 0xE0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722IC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722IC",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722IE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722RC",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722RE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722VC",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722ZC",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F722ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F722ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F723IC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F723IC",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F723IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F723IE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F723VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F723VC",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F723VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F723VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F723ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F723ZC",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F723ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F723ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F730I8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F730I8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F730R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F730R8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F730V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F730V8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F730Z8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F730Z8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F732IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F732IE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F732RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F732RE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F732VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F732VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F732ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F732ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F733IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F733IE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F733VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F733VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F733ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F733ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x60000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x30000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F745IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F745IE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F745IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F745IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F745VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F745VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F745VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F745VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F745ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F745ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F745ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F745ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746BE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746BE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746IE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746NE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746NE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746NG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F746ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F746ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F750N8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F750N8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F750V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F750V8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F750Z8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F750Z8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F756BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F756BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F756IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F756IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F756NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F756NG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F756VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F756VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F756ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F756ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20010000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765NG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765NI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F765ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F765ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767NG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767NI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F767ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F767ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F768AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F768AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769AG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769NG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0xC0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F769NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F769NI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F777BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F777BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F777II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F777II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F777NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F777NI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F777VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F777VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F777ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F777ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F778AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F778AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F779AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F779AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F779BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F779BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F779II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F779II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32F779NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32F779NI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x1C0000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x60000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G030C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G030C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G030C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G030C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G030F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G030F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G030J6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G030J6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G030K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G030K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G030K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G030K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031C4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031F8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031F8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031G4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031G4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031G8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031G8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031J4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031J4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031J6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031J6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031K4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G031Y8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G031Y8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041F8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041F8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041G8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041G8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041J6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041J6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G041Y8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G041Y8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G050C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G050C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G050C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G050C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G050F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G050F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G050K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G050K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G050K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G050K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051F8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051F8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051G8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051G8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G051K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G051K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061F8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061F8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061G8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061G8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G061K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G061K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G070CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G070CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G070KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G070KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G070RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G070RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071EB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071EB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071G8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071G8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071GB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071GB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071R6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G071RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G071RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G081CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G081CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G081EB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G081EB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G081GB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G081GB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G081KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G081KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G081RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G081RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x9000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B0CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B0CE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B0KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B0KE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B0RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B0RE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B0VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B0VE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1CC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1CE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1KC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1KE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1MB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1MB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1MC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1ME",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1NE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1NE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1RC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1RE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1VB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1VC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0B1VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0B1VE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1CC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1CE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1KC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1KE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1MC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1ME",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1NE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1NE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1RC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1RE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1VC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G0C1VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G0C1VE",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x24000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431C6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431K6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431K8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431KB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431M6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431M6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431M8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431M8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431MB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431MB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431R6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431V6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431V6",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431V8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G431VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G431VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G441CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G441CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G441KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G441KB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G441MB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G441MB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G441RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G441RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G441VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G441VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x1800, .kind = .ram },
            .{ .offset = 0x20005800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471MC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471QC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471QC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G471VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G471VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473MB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473MB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473MC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473PB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473PB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473PC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473PC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473PE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473PE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473QB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473QB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473QC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473QC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G473VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G473VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474MB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474MB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474MC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474PB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474PB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474PC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474PC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474PE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474PE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474QB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474QB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474QC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474QC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474VB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G474VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G474VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G483CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G483CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G483ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G483ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G483PE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G483PE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G483QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G483QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G483RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G483RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G483VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G483VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G484CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G484CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G484ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G484ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G484PE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G484PE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G484QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G484QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G484RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G484RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G484VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G484VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491KC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491KE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491MC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G491VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G491VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G4A1CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G4A1CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G4A1KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G4A1KE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G4A1ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G4A1ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G4A1RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G4A1RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32G4A1VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32G4A1VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20014000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20018000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H503CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H503CB",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H503EB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H503EB",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H503KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H503KB",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H503RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H503RB",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523CC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523HE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523HE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523RC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523RE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523VC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523VE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523ZC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H523ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H523ZE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H533CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H533CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H533HE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H533HE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H533RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H533RE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H533VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H533VE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H533ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H533ZE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x14000, .kind = .ram },
            .{ .offset = 0x20034000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562AG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562AI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562IG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562II",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562RG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562RI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562VG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562ZG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H562ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H562ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563AG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563AI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563IG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563II",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563MI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563MI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563RG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563RI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563VG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563ZG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H563ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H563ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H573AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H573AI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H573II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H573II",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H573MI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H573MI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H573RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H573RI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H573VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H573VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H573ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H573ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20050000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H723VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H723VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H723VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H723VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H723ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H723ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H723ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H723ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725AE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725AE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725AG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725IE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725IE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725RE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725RG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725VE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725ZE",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H725ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H725ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H730AB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H730AB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H730IB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H730IB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H730VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H730VB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H730ZB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H730ZB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H733VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H733VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H733ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H733ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H735AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H735AG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H735IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H735IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H735RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H735RG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H735VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H735VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H735ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H735ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x50000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742AG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742XG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742XG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742XI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742XI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H742ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H742ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x60000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x30020000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743AG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743XG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743XG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743XI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743XI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H743ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H743ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745XG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745XG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745XI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745XI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H745ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H745ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747AG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747BG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747BG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747XG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747XG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747XI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747XI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H747ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H747ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H750IB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H750IB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H750VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H750VB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H750XB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H750XB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H750ZB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H750ZB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H753AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H753AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H753BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H753BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H753II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H753II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H753VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H753VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H753XI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H753XI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H753ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H753ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x38000000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H755BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H755BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H755II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H755II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H755XI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H755XI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H755ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H755ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H757AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H757AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H757BI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H757BI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H757II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H757II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H757XI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H757XI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H757ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H757ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x48000, .kind = .ram },
            .{ .offset = 0x18000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3AG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3IG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3IG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3LG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3LG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3LI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3LI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3NG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3NG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3NI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3QI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3RG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3RI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3VG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3ZG",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7A3ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7A3ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B0AB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B0AB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B0IB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B0IB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B0RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B0RB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B0VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B0VB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B0ZB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B0ZB",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3AI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3II = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3II",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3LI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3LI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3NI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3QI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3RI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3VI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7B3ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7B3ZI",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x100000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R3A8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R3A8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R3I8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R3I8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R3L8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R3L8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R3R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R3R8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R3V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R3V8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R3Z8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R3Z8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R7A8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R7A8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R7I8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R7I8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R7L8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R7L8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7R7Z8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7R7Z8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S3A8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S3A8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S3I8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S3I8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S3L8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S3L8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S3R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S3R8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S3V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S3V8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S3Z8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S3Z8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S7A8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S7A8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S7I8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S7I8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S7L8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S7L8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32H7S7Z8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32H7S7Z8",
        .cpu = MicroZig.cpus.cortex_m7,
        .memory_regions = &.{
            .{ .offset = 0x0, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x24000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24020000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24040000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x24060000, .length = 0x12000, .kind = .ram },
            .{ .offset = 0x30000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x30004000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L010C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L010C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L010F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L010F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L010K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L010K4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L010K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L010K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L010R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L010R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L010RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L010RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011D3 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011D3",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x2000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011D4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011D4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011E3 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011E3",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x2000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011E4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011E4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011F3 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011F3",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x2000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011G3 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011G3",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x2000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011G4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011G4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011K3 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011K3",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x2000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L011K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L011K4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L021D4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L021D4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L021F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L021F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L021G4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L021G4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L021K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L021K4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031C4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031E4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031E4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031E6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031E6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031G4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031G4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031K4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L031K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L031K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L041C4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L041C4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L041C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L041C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L041E6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L041E6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L041F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L041F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L041G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L041G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L041K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L041K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051R6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051T6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051T6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L051T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L051T8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052R6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052T6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052T6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L052T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L052T8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L053C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L053C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L053C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L053C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L053R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L053R6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L053R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L053R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L062C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L062C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L062K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L062K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L063C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L063C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L063R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L063R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071CZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071CZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071KZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071KZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071RZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071RZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071V8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071VB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L071VZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L071VZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072CZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072CZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072KZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072KZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072RZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072RZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072V8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072VB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L072VZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L072VZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L073CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L073CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L073CZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L073CZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L073RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L073RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L073RZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L073RZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L073V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L073V8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L073VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L073VB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L073VZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L073VZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L081CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L081CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L081CZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L081CZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L081KZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L081KZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L082CZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L082CZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L082KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L082KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L082KZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L082KZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L083CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L083CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L083CZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L083CZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L083RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L083RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L083RZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L083RZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L083V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L083V8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L083VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L083VB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L083VZ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L083VZ",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x5000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L100C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L100C6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L100C6-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L100C6-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L100R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L100R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L100R8-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L100R8-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L100RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L100RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L100RB-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L100RB-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L100RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L100RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151C6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151C6-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151C6-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151C8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151C8-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151C8-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151CB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151CB-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151CB-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151CC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151QC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151QC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151QD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151QD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151QE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151R6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151R6-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151R6-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151R8-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151R8-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151RB-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151RB-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151RC-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151RC-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151RD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151UC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151UC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151V8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151V8-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151V8-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151VB-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151VB-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151VC-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151VC-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151VD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L151VD-X" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151VD-X",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151ZD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L151ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L151ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152C6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152C6-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152C6-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152C8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152C8-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152C8-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152CB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152CB-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152CB-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152CC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152QC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152QC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152QD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152QD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152QE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152R6",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152R6-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152R6-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152R8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152R8-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152R8-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152RB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152RB-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152RB-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152RC-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152RC-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152RD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152UC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152UC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152V8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152V8",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152V8-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152V8-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152VB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152VB",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152VB-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152VB-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152VC-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152VC-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152VD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L152VD-X" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152VD-X",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152ZD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L152ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L152ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162QC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162QC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162QD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162QD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162RC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L162RC-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162RC-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162RD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162RD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162RE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162VC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L162VC-A" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162VC-A",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162VD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162VD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const @"STM32L162VD-X" = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162VD-X",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162VE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162ZC",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162ZD = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162ZD",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x8030000, .length = 0x30000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L162ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L162ZE",
        .cpu = MicroZig.cpus.cortex_m3,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x14000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412K8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412KB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412R8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412T8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412T8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L412TB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L412TB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L422CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L422CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L422KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L422KB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L422RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L422RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L422TB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L422TB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x2000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x2000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L431CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L431CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L431CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L431CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L431KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L431KB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L431KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L431KC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L431RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L431RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L431RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L431RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L431VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L431VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L432KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L432KB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L432KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L432KC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L433CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L433CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L433CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L433CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L433RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L433RB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L433RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L433RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L433VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L433VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L442KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L442KC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L443CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L443CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L443RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L443RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L443VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L443VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x4000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0xC000, .kind = .ram },
            .{ .offset = 0x2000C000, .length = 0x4000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L451CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L451CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L451CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L451CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L451RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L451RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L451RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L451RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L451VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L451VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L451VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L451VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L452CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L452CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L452CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L452CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L452RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L452RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L452RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L452RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L452VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L452VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L452VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L452VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L462CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L462CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L462RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L462RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L462VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L462VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
            .{ .offset = 0x20020000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L471ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L471ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L475RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L475RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L475RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L475RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L475RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L475RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L475VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L475VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L475VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L475VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L475VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L475VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476JE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476JE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476JG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476JG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476ME",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476MG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476MG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L476ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L476ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L486JG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L486JG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L486QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L486QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L486RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L486RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L486VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L486VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L486ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L486ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496AE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496AE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496WG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496WG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L496ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L496ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4A6AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4A6AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4A6QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4A6QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4A6RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4A6RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4A6VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4A6VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4A6ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4A6ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5AE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5AE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5CG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5QE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5ZE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4P5ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4P5ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4Q5AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4Q5AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4Q5CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4Q5CG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4Q5QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4Q5QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4Q5RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4Q5RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4Q5VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4Q5VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4Q5ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4Q5ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x50000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5QG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5QI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R5ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R5ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R7AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R7AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R7VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R7VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R7ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R7ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R9AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R9AG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R9AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R9AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R9VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R9VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R9VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R9VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R9ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R9ZG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4R9ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4R9ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S5AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S5AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S5QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S5QI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S5VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S5VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S5ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S5ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S7AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S7AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S7VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S7VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S7ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S7ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S9AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S9AI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S9VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S9VI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L4S9ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L4S9ZI",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552CC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552ME",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552QC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552QC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552QE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552RC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552RE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552VC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552VE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552ZC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552ZC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L552ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L552ZE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L562CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L562CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L562ME = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L562ME",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L562QE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L562QE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L562RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L562RE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L562VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L562VE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32L562ZE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32L562ZE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031C6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031C6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031F4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031F4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031F6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031F6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031F8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031F8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031G6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031G6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031G8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031G8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031K4 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031K4",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x4000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031K6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031K6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031R6 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031R6",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x8000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U031R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U031R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073C8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073CB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073CC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073H8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073H8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073HB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073HB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073HC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073HC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073K8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073K8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073KB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073KB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073KC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073M8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073M8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073MB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073MB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073MC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073R8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073R8",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073RB",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U073RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U073RC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U083CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U083CC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U083HC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U083HC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U083KC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U083KC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U083MC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U083MC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U083RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U083RC",
        .cpu = MicroZig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xA000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535CB",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535CC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535JE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535JE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535NC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535NC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535NE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535NE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535RB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535RB",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x8010000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535RC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535RE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535VC",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x8020000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U535VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U535VE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U545CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U545CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U545JE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U545JE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U545NE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U545NE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U545RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U545RE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U545VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U545VE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x8040000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575AG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575AG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575AI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575CG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575CI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575CI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575OG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575OG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575OI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575OI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575QG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575QG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575QI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575RG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575RI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575VG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575ZG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575ZG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x8080000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U575ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U575ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U585AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U585AI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U585CI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U585CI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U585OI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U585OI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U585QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U585QI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U585RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U585RI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U585VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U585VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U585ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U585ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20040000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595AI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595AI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595AJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595AJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595QI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595QJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595QJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595RI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595RI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595RJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595RJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U595ZJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U595ZJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U599BJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U599BJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U599NI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U599NI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U599NJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U599NJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U599VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U599VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U599VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U599VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U599ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U599ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U599ZJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U599ZJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A5AJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A5AJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A5QI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A5QI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8100000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A5QJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A5QJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A5RJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A5RJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A5VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A5VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A5ZJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A5ZJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A9BJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A9BJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A9NJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A9NJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A9VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A9VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5A9ZJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5A9ZJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F7VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F7VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F7VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F7VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F9BJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F9BJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F9NJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F9NJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F9VI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F9VI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F9VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F9VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F9ZI = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F9ZI",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5F9ZJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5F9ZJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5G7VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5G7VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5G9BJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5G9BJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5G9NJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5G9NJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5G9VJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5G9VJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32U5G9ZJ = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32U5G9ZJ",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x8200000, .length = 0x200000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0xC0000, .kind = .ram },
            .{ .offset = 0x200C0000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x200D0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x201A0000, .length = 0xD0000, .kind = .ram },
            .{ .offset = 0x20270000, .length = 0x80000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB10CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB10CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x50000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB15CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB15CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x50000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x1000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x3000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x1000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB30CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB30CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB35CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB35CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB35CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB35CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB50CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB50CG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55CE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55CG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55RC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55RC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55RE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55RE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55RG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55RG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55VC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55VC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55VE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55VE",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55VG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55VG",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WB55VY = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WB55VY",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0xA0000, .kind = .flash },
            .{ .offset = 0x10000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x10008000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20000000, .length = 0x30000, .kind = .ram },
            .{ .offset = 0x20030000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20038000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA50KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA50KE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA50KG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA50KG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA52CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA52CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA52CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA52CG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA52KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA52KE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA52KG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA52KG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA54CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA54CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA54CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA54CG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA54KE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA54KE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA54KG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA54KG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA55CE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA55CE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA55CG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA55CG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA55HE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA55HE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA55HG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA55HG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA55UE = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA55UE",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x80000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x18000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WBA55UG = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WBA55UG",
        .cpu = MicroZig.cpus.cortex_m33,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x100000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x20000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WL54CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WL54CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WL54JC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WL54JC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WL55CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WL55CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WL55JC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WL55JC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE4C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE4C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20002800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE4CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE4CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
            .{ .offset = 0x20006000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE4CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE4CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE4J8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE4J8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20002800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE4JB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE4JB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
            .{ .offset = 0x20006000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE4JC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE4JC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE5C8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE5C8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20002800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE5CB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE5CB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
            .{ .offset = 0x20006000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE5CC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE5CC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE5J8 = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE5J8",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x10000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x2800, .kind = .ram },
            .{ .offset = 0x20002800, .length = 0x2800, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE5JB = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE5JB",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x20000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x6000, .kind = .ram },
            .{ .offset = 0x20006000, .length = 0x6000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};

pub const STM32WLE5JC = MicroZig.Target{
    .preferred_format = .elf,
    .chip = .{
        .name = "STM32WLE5JC",
        .cpu = MicroZig.cpus.cortex_m4,
        .memory_regions = &.{
            .{ .offset = 0x8000000, .length = 0x40000, .kind = .flash },
            .{ .offset = 0x20000000, .length = 0x8000, .kind = .ram },
            .{ .offset = 0x20008000, .length = 0x8000, .kind = .ram },
        },
        .register_definition = .{
            .zig = .{ .cwd_relative = register_definition_path },
        },
    },
};
