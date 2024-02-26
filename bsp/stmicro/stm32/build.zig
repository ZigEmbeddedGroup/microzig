const std = @import("std");
const MicroZig = @import("microzig/build");

pub const microzig_board_support = MicroZig.registerBoardSupport(@This());

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

const KiB = 1024;

////////////////////////////////////////
//      MicroZig Gen 2 Interface      //
////////////////////////////////////////

pub fn build(b: *std.Build) !void {
    _ = b;
    //  Dummy func to make package manager happy
}

pub const chips = struct {
    pub const stm32f103x8 = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F103",
            .cpu = MicroZig.cpus.cortex_m3,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F103.json" },
            },
        },
        .hal = .{
            .source_file = .{ .cwd_relative = build_root ++ "/src/hals/STM32F103/hal.zig" },
        },
    };

    pub const stm32f303vc = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F303",
            .cpu = MicroZig.cpus.cortex_m4,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 256 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 40 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F303.json" },
            },
        },
    };

    pub const stm32f407vg = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F407",
            .cpu = MicroZig.cpus.cortex_m4,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 1024 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 128 * KiB, .kind = .ram },
                .{ .offset = 0x10000000, .length = 64 * KiB, .kind = .ram }, // CCM RAM
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F407.json" },
            },
        },
    };

    pub const stm32f429zit6u = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "STM32F429",
            .cpu = MicroZig.cpus.cortex_m4,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 2048 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 192 * KiB, .kind = .ram },
                .{ .offset = 0x10000000, .length = 64 * KiB, .kind = .ram }, // CCM RAM
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F429.json" },
            },
        },
    };

    // All STM32L0x1 series MCUs differ only in memory size. So we create a comptime function
    // to generate all MCU variants as per https://www.st.com/en/microcontrollers-microprocessors/stm32l0x1.html
    fn stm32l0x1(comptime rom_size: u64, comptime ram_size: u64) MicroZig.Target {
        return MicroZig.Target{
            .preferred_format = .elf,
            .chip = .{
                .name = "STM32L0x1",
                .cpu = MicroZig.cpus.cortex_m0plus,
                .memory_regions = &.{
                    .{ .offset = 0x08000000, .length = rom_size, .kind = .flash },
                    .{ .offset = 0x20000000, .length = ram_size, .kind = .ram },
                },
                .register_definition = .{
                    .svd = .{ .cwd_relative = build_root ++ "/src/chips/STM32L0x1.svd" },
                },
            },
        };
    }

    pub const stm32l011x3 = stm32l0x1(8 * KiB, 2 * KiB);

    pub const stm32l011x4 = stm32l0x1(16 * KiB, 2 * KiB);
    pub const stm32l021x4 = stm32l0x1(16 * KiB, 2 * KiB);
    pub const stm32l031x4 = stm32l0x1(16 * KiB, 8 * KiB);

    pub const stm32l031x6 = stm32l0x1(32 * KiB, 8 * KiB);
    pub const stm32l041x6 = stm32l0x1(32 * KiB, 8 * KiB);
    pub const stm32l051x6 = stm32l0x1(32 * KiB, 8 * KiB);

    pub const stm32l051x8 = stm32l0x1(64 * KiB, 8 * KiB);
    pub const stm32l071x8 = stm32l0x1(64 * KiB, 20 * KiB);

    pub const stm32l071xb = stm32l0x1(128 * KiB, 20 * KiB);
    pub const stm32l081cb = stm32l0x1(128 * KiB, 20 * KiB);

    pub const stm32l071xz = stm32l0x1(192 * KiB, 20 * KiB);
    pub const stm32l081xz = stm32l0x1(192 * KiB, 20 * KiB);

    // All STM32L0x2 series MCUs differ only in memory size. So we create a comptime function
    // to generate all MCU variants as per https://www.st.com/en/microcontrollers-microprocessors/stm32l0x2.html
    fn stm32l0x2(comptime rom_size: u64, comptime ram_size: u64) MicroZig.Target {
        return MicroZig.Target{
            .preferred_format = .elf,
            .chip = .{
                .name = "STM32L0x2",
                .cpu = MicroZig.cpus.cortex_m0plus,
                .memory_regions = &.{
                    .{ .offset = 0x08000000, .length = rom_size, .kind = .flash },
                    .{ .offset = 0x20000000, .length = ram_size, .kind = .ram },
                },
                .register_definition = .{
                    .svd = .{ .cwd_relative = build_root ++ "/src/chips/STM32L0x2.svd" },
                },
            },
        };
    }

    pub const stm32l052x6 = stm32l0x2(32 * KiB, 8 * KiB);

    pub const stm32l052x8 = stm32l0x2(64 * KiB, 8 * KiB);
    pub const stm32l062x8 = stm32l0x2(64 * KiB, 8 * KiB);
    pub const stm32l072v8 = stm32l0x2(64 * KiB, 20 * KiB);

    pub const stm32l072xb = stm32l0x2(128 * KiB, 20 * KiB);
    pub const stm32l082xb = stm32l0x2(128 * KiB, 20 * KiB);

    pub const stm32l072xz = stm32l0x2(192 * KiB, 20 * KiB);
    pub const stm32l082xz = stm32l0x2(192 * KiB, 20 * KiB);

    // All STM32L0x2 series MCUs differ only in memory size. So we create a comptime function
    // to generate all MCU variants as per https://www.st.com/en/microcontrollers-microprocessors/stm32l0x3.html
    fn stm32l0x3(comptime rom_size: u64, comptime ram_size: u64) MicroZig.Target {
        return MicroZig.Target{
            .preferred_format = .elf,
            .chip = .{
                .name = "STM32L0x3",
                .cpu = MicroZig.cpus.cortex_m0plus,
                .memory_regions = &.{
                    .{ .offset = 0x08000000, .length = rom_size, .kind = .flash },
                    .{ .offset = 0x20000000, .length = ram_size, .kind = .ram },
                },
                .register_definition = .{
                    .svd = .{ .cwd_relative = build_root ++ "/src/chips/STM32L0x3.svd" },
                },
            },
        };
    }

    pub const stm32l053x6 = stm32l0x2(32 * KiB, 8 * KiB);

    pub const stm32l053x8 = stm32l0x2(64 * KiB, 8 * KiB);
    pub const stm32l063x8 = stm32l0x2(64 * KiB, 8 * KiB);

    pub const stm32l073v8 = stm32l0x2(64 * KiB, 20 * KiB);
    pub const stm32l083v8 = stm32l0x2(64 * KiB, 20 * KiB);

    pub const stm32l073xb = stm32l0x2(128 * KiB, 20 * KiB);
    pub const stm32l083xb = stm32l0x2(128 * KiB, 20 * KiB);

    pub const stm32l073xz = stm32l0x2(192 * KiB, 20 * KiB);
    pub const stm32l083xz = stm32l0x2(192 * KiB, 20 * KiB);
};

pub const boards = struct {
    pub const stm32f3discovery = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.stm32f303vc.chip,
        .board = .{
            .name = "STM32F3DISCOVERY",
            .source_file = .{ .path = build_root ++ "/src/boards/STM32F3DISCOVERY.zig" },
        },
    };

    pub const stm32f4discovery = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.stm32f407vg.chip,
        .board = .{
            .name = "STM32F4DISCOVERY",
            .source_file = .{ .path = build_root ++ "/src/boards/STM32F4DISCOVERY.zig" },
        },
    };

    pub const stm3240geval = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.stm32f407vg.chip,
        .board = .{
            .name = "STM3240G_EVAL",
            .source_file = .{ .path = build_root ++ "/src/boards/STM3240G_EVAL.zig" },
        },
    };

    pub const stm32f429idiscovery = MicroZig.Target{
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
