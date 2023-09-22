const std = @import("std");
const microzig = @import("root").dependencies.imports.microzig; // HACK: Please import MicroZig always under the name `microzig`. Otherwise the RP2040 module will fail to be properly imported.

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

////////////////////////////////////////
//      MicroZig Gen 2 Interface      //
////////////////////////////////////////

pub fn build(b: *std.Build) !void {
    _ = b;
    //  Dummy func to make package manager happy
}

pub const chips = struct {
    pub const stm32f103x8 = .{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F103",
            .cpu = .cortex_m3,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F103.json" },
            },
        },
    };

    pub const stm32f303vc = .{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F303",
            .cpu = .cortex_m4,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 256 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 40 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F303.json" },
            },
        },
    };

    pub const stm32f407vg = .{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F407",
            .cpu = .cortex_m4,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 1024 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 128 * 1024, .kind = .ram },
                .{ .offset = 0x10000000, .length = 64 * 1024, .kind = .ram }, // CCM RAM
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F407.json" },
            },
        },
    };

    pub const stm32f429zit6u = .{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F429",
            .cpu = .cortex_m4,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 2048 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 192 * 1024, .kind = .ram },
                .{ .offset = 0x10000000, .length = 64 * 1024, .kind = .ram }, // CCM RAM
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F429.json" },
            },
        },
    };
};

pub const boards = struct {
    pub const stm32f3discovery = .{
        .preferred_format = .elf,
        .chip = chips.stm32f303vc.chip,
        .board = .{
            .name = "STM32F3DISCOVERY",
            .source_file = .{ .path = build_root ++ "/src/boards/STM32F3DISCOVERY.zig" },
        },
    };

    pub const stm32f4discovery = .{
        .preferred_format = .elf,
        .chip = chips.stm32f407vg.chip,
        .board = .{
            .name = "STM32F4DISCOVERY",
            .source_file = .{ .path = build_root ++ "/src/boards/STM32F4DISCOVERY.zig" },
        },
    };

    pub const stm3240geval = .{
        .preferred_format = .elf,
        .chip = chips.stm32f407vg.chip,
        .board = .{
            .name = "STM3240G_EVAL",
            .source_file = .{ .path = build_root ++ "/src/boards/STM3240G_EVAL.zig" },
        },
    };

    pub const stm32f429idiscovery = .{
        .preferred_format = .elf,
        .chip = chips.stm32f429zit6u.chip,
        .board = .{
            .name = "STM32F429IDISCOVERY",
            .source_file = .{ .path = build_root ++ "/src/boards/STM32F429IDISCOVERY.zig" },
        },
    };
};

// pub fn build(b: *std.build.Builder) void {
//     _ = b;
// const optimize = b.standardOptimizeOption(.{});
// inline for (@typeInfo(boards).Struct.decls) |decl| {
//     if (!decl.is_pub)
//         continue;

//     const exe = microzig.addEmbeddedExecutable(b, .{
//         .name = @field(boards, decl.name).name ++ ".minimal",
//         .source_file = .{
//             .path = "test/programs/minimal.zig",
//         },
//         .backing = .{ .board = @field(boards, decl.name) },
//         .optimize = optimize,
//     });
//     exe.installArtifact(b);
// }

// inline for (@typeInfo(chips).Struct.decls) |decl| {
//     if (!decl.is_pub)
//         continue;

//     const exe = microzig.addEmbeddedExecutable(b, .{
//         .name = @field(chips, decl.name).name ++ ".minimal",
//         .source_file = .{
//             .path = "test/programs/minimal.zig",
//         },
//         .backing = .{ .chip = @field(chips, decl.name) },
//         .optimize = optimize,
//     });
//     exe.installArtifact(b);
// }
// }
