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
    ch32v305xb: *const microzig.Target,
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

    const qingkev2a_target: std.Target.Query = .{
        // QingKe V2C is RV32EC
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic },
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            .@"32bit",
            .e,
            .c,
        }),
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const qingkev2_cpu: microzig.Cpu = .{
        .name = "qingkev2-rv32ec",
        .root_source_file = b.path("src/cpus/qingkev2-rv32ec.zig"),
    };

    const qingkev3_target: std.Target.Query = .{
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

    const qingkev3_cpu: microzig.Cpu = .{
        .name = "qingkev3-rv32imac",
        .root_source_file = b.path("src/cpus/qingkev3-rv32imac.zig"),
    };

    const qingkev4b_target: std.Target.Query = .{
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

    const qingkev4f_target: std.Target.Query = .{
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

    const qingkev4_cpu: microzig.Cpu = .{
        .name = "qingkev4-rv32imac",
        .root_source_file = b.path("src/cpus/qingkev4-rv32imac.zig"),
    };

    const chip_ch32v003x4: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .zig_target = qingkev2a_target,
        .cpu = qingkev2_cpu,
        .chip = .{
            .name = "CH32V00xxx", // <name/> from SVD
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

    const chip_ch32v103x8: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .zig_target = qingkev3_target,
        .cpu = qingkev3_cpu,
        .chip = .{
            .name = "CH32V103xx", // <name/> from SVD
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

    const chip_ch32v103x6: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .zig_target = qingkev3_target,
        .cpu = qingkev3_cpu,
        .chip = .{
            .name = "CH32V103xx", // <name/> from SVD
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

    const chip_ch32v203x8: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .zig_target = qingkev4b_target,
        .cpu = qingkev4_cpu,
        .chip = .{
            .name = "CH32V20xxx", // <name/> from SVD
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

    const chip_ch32v203x6: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .zig_target = qingkev4b_target,
        .cpu = qingkev4_cpu,
        .chip = .{
            .name = "CH32V20xxx", // <name/> from SVD
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

    const chip_ch32v305xb: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .zig_target = qingkev4f_target,
        .cpu = qingkev4_cpu,
        .chip = .{
            .name = "CH32V30xxx", // <name/> from SVD
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 128 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 32 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .svd = b.path("src/chips/ch32v30x.svd"),
            },
        },
        .hal = hal_ch32v307,
    };

    const chip_ch32v307xc: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .bin,
        .zig_target = qingkev4f_target,
        .cpu = qingkev4_cpu,
        .chip = .{
            .name = "CH32V30xxx", // <name/> from SVD
            .memory_regions = &.{
                // From datasheet:
                // The products with 256K FLASH+64K SRAM support user select word to be configured as one of several
                // combinations of (192K FLASH+128K SRAM), (224K FLASH+96K SRAM), (256K FLASH+64K SRAM),
                // (288K FLASH+32K SRAM). On this basis, the 256K FLASH+64K SRAM product with the sixth inverted
                // batch number not equal to 0 has also added a configuration combination: (128K FLASH+192K SRAM).
                // FLASH flash represents the zero-waiting running area R0WAIT, and the product of 256K FLASH+64K
                // SRAM supports the non-zero waiting area of (480K-R0WAIT) bytes.
                .{ .offset = 0x08000000, .length = 256 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 64 * KiB, .kind = .ram },
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
            .ch32v305xb = chip_ch32v305xb.derive(.{}),
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
