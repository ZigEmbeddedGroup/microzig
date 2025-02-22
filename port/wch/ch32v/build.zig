const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

const KiB = 1024;

chips: struct {
    ch32v003x4: *const microzig.Target,
    ch32v103x6: *const microzig.Target,
    ch32v103x8: *const microzig.Target,
    ch32v203x6: *const microzig.Target,
    ch32v203x8: *const microzig.Target,
    ch32v307xc: *const microzig.Target,
},

boards: struct {
    ch32v003: struct {
        ch32v003f4p6_r0_1v1: *const microzig.Target,
    },
    ch32v103: struct {
        ch32v103r_r1_1v1: *const microzig.Target,
    },
    ch32v203: struct {
        suzuduino_uno_v1b: *const microzig.Target,
    },
    ch32v307: struct {
        ch32v307v_r1_1v0: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const hal_ch32v003: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hals/hal_ch32v003.zig"),
    };
    const hal_ch32v103: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hals/hal_ch32v103.zig"),
    };
    const hal_ch32v203: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hals/hal_ch32v203.zig"),
    };
    const hal_ch32v307: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hals/hal_ch32v307.zig"),
    };

    const qingkev2a = std.Target.Query{
        // QingKe V2C is RV32EC
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic },
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.@"32bit",
            std.Target.riscv.Feature.e,
            std.Target.riscv.Feature.c,
        }),
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const qingkev3 = std.Target.Query{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        // generic_rv32 has feature I.
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.c,
            std.Target.riscv.Feature.a,
            std.Target.riscv.Feature.m,
        }),
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const qingkev4b = std.Target.Query{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        // generic_rv32 has feature I.
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.c,
            std.Target.riscv.Feature.a,
            std.Target.riscv.Feature.m,
        }),
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const qingkev4f = std.Target.Query{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        // generic_rv32 has feature I.
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.c,
            std.Target.riscv.Feature.a,
            std.Target.riscv.Feature.m,
            std.Target.riscv.Feature.f,
        }),
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const chip_ch32v003x4: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .chip = .{
            .name = "CH32V00xxx", // <name/> from SVD
            .cpu = qingkev2a,
            .cpu_module_file = b.path("src/cpus/qingkev2-rv32ec.zig"),
            .register_definition = .{
                .svd = b.path("src/chips/ch32v003.svd"),
            },
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 16 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 2 * KiB, .kind = .ram },
            },
        },
        .hal = hal_ch32v003,
    };

    const chip_ch32v103x8 = microzig.Target{
        .dep = dep,
        .preferred_binary_format = .bin,
        .chip = .{
            .name = "CH32V103xx", // <name/> from SVD
            .cpu = qingkev3,
            .cpu_module_file = b.path("src/cpus/qingkev3-rv32imac.zig"),
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .svd = b.path("src/chips/ch32v103.svd"),
            },
        },
        .hal = hal_ch32v103,
    };

    const chip_ch32v103x6 = microzig.Target{
        .dep = dep,
        .preferred_binary_format = .bin,
        .chip = .{
            .name = "CH32V103xx", // <name/> from SVD
            .cpu = qingkev3,
            .cpu_module_file = b.path("src/cpus/qingkev3-rv32imac.zig"),
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 32 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 10 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .svd = b.path("src/chips/ch32v103.svd"),
            },
        },
        .hal = hal_ch32v103,
    };

    const chip_ch32v203x8 = microzig.Target{
        .dep = dep,

        .preferred_binary_format = .bin,
        .chip = .{
            .name = "CH32V20xxx", // <name/> from SVD
            .cpu = qingkev4b,
            .cpu_module_file = b.path("src/cpus/qingkev4-rv32imac.zig"),
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .svd = b.path("src/chips/ch32v20x.svd"),
            },
        },
        .hal = hal_ch32v203,
    };

    const chip_ch32v203x6 = microzig.Target{
        .dep = dep,
        .preferred_binary_format = .bin,
        .chip = .{
            .name = "CH32V20xxx", // <name/> from SVD
            .cpu = qingkev4b,
            .cpu_module_file = b.path("src/cpus/qingkev4-rv32imac.zig"),
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 32 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 10 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .svd = b.path("src/chips/ch32v20x.svd"),
            },
        },
        .hal = hal_ch32v203,
    };

    const chip_ch32v307xc = microzig.Target{
        .dep = dep,
        .preferred_binary_format = .bin,
        .chip = .{
            .name = "CH32V30xxx", // <name/> from SVD
            .cpu = qingkev4f,
            .cpu_module_file = b.path("src/cpus/qingkev4-rv32imac.zig"),
            .memory_regions = &.{
                // FLASH + RAM supports the following configuration
                // FLASH-192K + RAM-128K
                // FLASH-224K + RAM-96K
                // FLASH-256K + RAM-64K
                // FLASH-288K + RAM-32K
                // FLASH-128K + RAM-192K
                .{ .offset = 0x08000000, .length = 128 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 32 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .svd = b.path("src/chips/ch32v30x.svd"),
            },
        },
        .hal = hal_ch32v307,
    };

    const board_ch32v003f4p6_r0_1v1 = chip_ch32v003x4.derive(.{
        .board = .{
            .name = "WCH CH32V003F4P6-R0-1v1",
            .url = "https://www.wch-ic.com/products/CH32V003.html",
            .root_source_file = b.path("src/boards/CH32V003F4P6-R0-1v1.zig"),
        },
    });

    const board_ch32v103r_r1_1v1 = chip_ch32v103x8.derive(.{
        .board = .{
            .name = "WCH CH32V103R-R1-1v1",
            .url = "https://github.com/openwch/ch32v103/tree/main/SCHPCB/CH32V103R-R1-1v1",
            .root_source_file = b.path("src/boards/CH32V103-R1-1v1.zig"),
        },
    });

    const board_suzuduino_uno_v1b = chip_ch32v203x8.derive(.{
        .board = .{
            .name = "WCH Suzuduino Uno V1b",
            .url = "https://github.com/verylowfreq/suzuduino-uno-v1",
            .root_source_file = b.path("src/boards/Suzuduino_Uno_V1b.zig"),
        },
    });

    const board_ch32v307v_r1_1v0 = chip_ch32v307xc.derive(.{
        .board = .{
            .name = "WCH CH32V307V-R1-1V0",
            .url = "https://github.com/openwch/ch32v307/tree/main/SCHPCB/CH32V307V-R1-1v0",
            .root_source_file = b.path("src/boards/CH32V307V-R1-1v0.zig"),
        },
    });

    return .{
        .chips = .{
            .ch32v003x4 = chip_ch32v003x4.derive(.{}),
            .ch32v103x6 = chip_ch32v103x6.derive(.{}),
            .ch32v103x8 = chip_ch32v103x8.derive(.{}),
            .ch32v203x6 = chip_ch32v203x6.derive(.{}),
            .ch32v203x8 = chip_ch32v203x8.derive(.{}),
            .ch32v307xc = chip_ch32v307xc.derive(.{}),
        },

        .boards = .{
            .ch32v003 = .{
                .ch32v003f4p6_r0_1v1 = board_ch32v003f4p6_r0_1v1,
            },
            .ch32v103 = .{
                .ch32v103r_r1_1v1 = board_ch32v103r_r1_1v1,
            },
            .ch32v203 = .{
                .suzuduino_uno_v1b = board_suzuduino_uno_v1b,
            },
            .ch32v307 = .{
                .ch32v307v_r1_1v0 = board_ch32v307v_r1_1v0,
            },
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
