const std = @import("std");
const Build = std.Build;
const MicroZig = @import("microzig/build");

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const hal_ch32v003 = .{
    .root_source_file = path("/src/hals/hal_ch32v003.zig"),
};
const hal_ch32v103 = .{
    .root_source_file = path("/src/hals/hal_ch32v103.zig"),
};
const hal_ch32v203 = .{
    .root_source_file = path("/src/hals/hal_ch32v203.zig"),
};

const qingkev2a = .{
    // QingKe V2C is RV32EmC
    .name = "QingKeV2A",
    .root_source_file = path("/src/cpus/qingkev2-rv32ec.zig"),
    .target = std.Target.Query{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic },
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.@"32bit",
            std.Target.riscv.Feature.e,
            std.Target.riscv.Feature.c,
        }),
        .os_tag = .freestanding,
        .abi = .none,
    },
};

const qingkev3 = .{
    .name = "QingKeV3",
    .root_source_file = path("/src/cpus/qingkev3-rv32imac.zig"),
    .target = std.Target.Query{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        // generic_rv32 has feature I.
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.c,
            std.Target.riscv.Feature.a,
            std.Target.riscv.Feature.m,
        }),
        .os_tag = .freestanding,
        .abi = .none,
    },
};

const qingkev4b = .{
    .name = "QingKeV4B",
    .root_source_file = path("/src/cpus/qingkev4-rv32imac.zig"),
    .target = std.Target.Query{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        // generic_rv32 has feature I.
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.c,
            std.Target.riscv.Feature.a,
            std.Target.riscv.Feature.m,
        }),
        .os_tag = .freestanding,
        .abi = .none,
    },
};

pub const chips = struct {
    pub const ch32v003x4 = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "CH32V00xxx", // <name/> from SVD
            .cpu = qingkev2a,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 16 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 2 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .svd = path("/src/chips/ch32v003.svd"),
            },
        },
        .hal = hal_ch32v003,
    };

    pub const ch32v103x8 = MicroZig.Target{
        .preferred_format = .bin,
        .chip = .{
            .name = "CH32V103xx", // <name/> from SVD
            .cpu = qingkev3,
            // .cpu = MicroZig.cpus.riscv32_imac,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .svd = path("/src/chips/ch32v103.svd"),
            },
        },
        .hal = hal_ch32v103,
    };

    pub const ch32v103x6 = MicroZig.Target{
        .preferred_format = .bin,
        .chip = .{
            .name = "CH32V103xx", // <name/> from SVD
            .cpu = qingkev3,
            // .cpu = MicroZig.cpus.riscv32_imac,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 32 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 10 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .svd = path("/src/chips/ch32v103.svd"),
            },
        },
        .hal = hal_ch32v103,
    };

    pub const ch32v203x8 = MicroZig.Target{
        .preferred_format = .bin,
        .chip = .{
            .name = "CH32V20xxx", // <name/> from SVD
            .cpu = qingkev4b,
            // .cpu = MicroZig.cpus.riscv32_imac,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .svd = path("/src/chips/ch32v20x.svd"),
            },
        },
        .hal = hal_ch32v203,
    };

    pub const ch32v203x6 = MicroZig.Target{
        .preferred_format = .bin,
        .chip = .{
            .name = "CH32V20xxx", // <name/> from SVD
            .cpu = qingkev4b,
            // .cpu = MicroZig.cpus.riscv32_imac,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 32 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 10 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .svd = path("/src/chips/ch32v20x.svd"),
            },
        },
        .hal = hal_ch32v203,
    };
};

pub const boards = struct {
    pub const ch32v003 = struct {
        pub const ch32v003f4p6_r0_1v1 = MicroZig.Target{
            .preferred_format = .elf,
            .chip = chips.ch32v003.chip,
            .hal = hal_ch32v003,
            .board = .{
                .name = "WCH CH32V003F4P6-R0-1v1",
                .url = "https://www.wch-ic.com/products/CH32V003.html",
                .root_source_file = path("/src/boards/CH32V003F4P6-R0-1v1.zig"),
            },
        };
    };

    pub const ch32v103 = struct {
        pub const ch32v103r_r1_1v1 = MicroZig.Target{
            .preferred_format = .bin,
            .chip = chips.ch32v103x8.chip,
            .hal = hal_ch32v103,
            .board = .{
                .name = "WCH CH32V103R-R1-1v1",
                .url = "https://github.com/openwch/ch32v103/tree/main/SCHPCB/CH32V103R-R1-1v1",
                .root_source_file = path("/src/boards/CH32V103-R1-1v1.zig"),
            },
        };
    };

    pub const ch32v203 = struct {
        pub const suzuduino_uno_v1b = MicroZig.Target{
            .preferred_format = .bin,
            .chip = chips.ch32v203x8.chip,
            .hal = hal_ch32v203,
            .board = .{
                .name = "WCH Suzuduino Uno V1b",
                .url = "https://github.com/verylowfreq/suzuduino-uno-v1",
                .root_source_file = path("/src/boards/Suzuduino_Uno_V1b.zig"),
            },
        };
    };
};

pub fn build(b: *Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
