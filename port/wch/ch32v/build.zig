const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

const KiB = 1024;

const BaseChip = struct {
    name: []const u8,
    cpu_features: std.Target.Cpu.Feature.Set,
    cpu: microzig.Cpu,
    hal: microzig.HardwareAbstractionLayer,
    svd: std.Build.LazyPath,

    fn create(self: BaseChip, dep: *std.Build.Dependency, mem: []const microzig.MemoryRegion) *microzig.Target {
        const ret = dep.builder.allocator.create(microzig.Target) catch @panic("out of memory");
        ret.* = .{
            .dep = dep,
            .preferred_binary_format = .bin,
            .zig_target = std.Target.Query{
                .cpu_arch = .riscv32,
                .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic },
                .cpu_features_add = self.cpu_features,
                .os_tag = .freestanding,
                .abi = .eabi,
            },
            .cpu = self.cpu,
            .chip = .{
                .name = self.name,
                .memory_regions = mem,
                .register_definition = .{
                    .svd = self.svd,
                },
            },
            .hal = self.hal,
        };

        return ret;
    }
};

// Generated with:
// curl 'https://www.wch-ic.com/api/product_tables/47?page=1&limit=100' | jq -r '.data[] | select(.["Part NO."] | startswith("CH32V")) | [ "    ", (.["Part NO."] | ascii_downcase), ": *const microzig.Target, // ", .Flash, " / ", .SRAM, " / ", .Freq ] | join("")' | awk 'match($0, /    ch32v/) { $0 = substr($0, 1, RSTART+11) "x" substr($0, RSTART+13, 1) substr($0, RSTART+16) }; {print}' | sort -n | uniq
chips: struct {
    ch32v003x4: *const microzig.Target, // 16K / 2K / 48MHz
    ch32v103x6: *const microzig.Target, // 32K / 10K / 80MHz
    ch32v103x8: *const microzig.Target, // 64K / 20K / 80MHz
    ch32v203x6: *const microzig.Target, // 32K / 10K / 144MHz
    ch32v203x8: *const microzig.Target, // 64K / 20K / 144MHz
    ch32v203xb: *const microzig.Target, // 128K / 64K / 144MHz
    ch32v208xb: *const microzig.Target, // 128K / 64K / 144MHz
    ch32v303xb: *const microzig.Target, // 128K / 32K / 144MHz
    ch32v303xc: *const microzig.Target, // 256K / 64K / 144MHz
    ch32v305xb: *const microzig.Target, // 128K / 32K / 144MHz
    ch32v307xc: *const microzig.Target, // 256K / 64K / 144MHz
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
    ch32v305: struct {
        nano_ch32v305: *const microzig.Target,
    },
    ch32v307: struct {
        ch32v307v_r1_1v0: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const mem_16k_2k: []const microzig.MemoryRegion = &.{
        .{ .offset = 0x08000000, .length = 16 * KiB, .kind = .flash },
        .{ .offset = 0x20000000, .length = 2 * KiB, .kind = .ram },
    };
    const mem_32k_10k: []const microzig.MemoryRegion = &.{
        .{ .offset = 0x08000000, .length = 32 * KiB, .kind = .flash },
        .{ .offset = 0x20000000, .length = 10 * KiB, .kind = .ram },
    };
    const mem_64k_20k: []const microzig.MemoryRegion = &.{
        .{ .offset = 0x08000000, .length = 64 * KiB, .kind = .flash },
        .{ .offset = 0x20000000, .length = 20 * KiB, .kind = .ram },
    };
    const mem_128k_32k: []const microzig.MemoryRegion = &.{
        .{ .offset = 0x08000000, .length = 128 * KiB, .kind = .flash },
        .{ .offset = 0x20000000, .length = 32 * KiB, .kind = .ram },
    };
    const mem_128k_64k: []const microzig.MemoryRegion = &.{
        .{ .offset = 0x08000000, .length = 128 * KiB, .kind = .flash },
        .{ .offset = 0x20000000, .length = 64 * KiB, .kind = .ram },
    };
    const mem_256k_64k: []const microzig.MemoryRegion = &.{
        .{ .offset = 0x08000000, .length = 256 * KiB, .kind = .flash },
        .{ .offset = 0x20000000, .length = 64 * KiB, .kind = .ram },
    };

    const chip_ch32v003_base: BaseChip = .{
        .name = "CH32V00xxx", // <name/> from SVD
        .cpu_features = std.Target.riscv.featureSet(&.{ .@"32bit", .e, .c, .xwchc }),
        .cpu = .{
            .name = "qingkev2-rv32ec",
            .root_source_file = b.path("src/cpus/qingkev2-rv32ec.zig"),
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ch32v003.zig"),
        },
        .svd = b.path("src/chips/ch32v003.svd"),
    };

    const chip_ch32v103_base: BaseChip = .{
        .name = "CH32V103xx", // <name/> from SVD
        .cpu_features = std.Target.riscv.featureSet(&.{ .@"32bit", .i, .m, .a, .c, .xwchc }),
        .cpu = .{
            .name = "qingkev3-rv32imac",
            .root_source_file = b.path("src/cpus/qingkev3-rv32imac.zig"),
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ch32v103.zig"),
        },
        .svd = b.path("src/chips/ch32v103.svd"),
    };

    const chip_ch32v20x_base: BaseChip = .{
        .name = "CH32V20xxx", // <name/> from SVD
        .cpu_features = std.Target.riscv.featureSet(&.{ .@"32bit", .i, .m, .a, .c, .xwchc }),
        .cpu = .{
            .name = "qingkev4-rv32imac",
            .root_source_file = b.path("src/cpus/qingkev4-rv32imac.zig"),
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ch32v20x.zig"),
        },
        .svd = b.path("src/chips/ch32v20x.svd"),
    };

    const chip_ch32v30x_base: BaseChip = .{
        .name = "CH32V30xxx", // <name/> from SVD
        .cpu_features = std.Target.riscv.featureSet(&.{ .@"32bit", .i, .m, .a, .f, .c, .xwchc }),
        .cpu = .{
            .name = "qingkev4-rv32imafc",
            .root_source_file = b.path("src/cpus/qingkev4-rv32imac.zig"),
            // TODO
            //.root_source_file = b.path("src/cpus/qingkev4-rv32imafc.zig"),
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ch32v30x.zig"),
        },
        .svd = b.path("src/chips/ch32v30x.svd"),
    };

    const chip_ch32v003x4 = chip_ch32v003_base.create(dep, mem_16k_2k);
    const chip_ch32v103x6 = chip_ch32v103_base.create(dep, mem_32k_10k);
    const chip_ch32v103x8 = chip_ch32v103_base.create(dep, mem_64k_20k);
    const chip_ch32v203x6 = chip_ch32v20x_base.create(dep, mem_32k_10k);
    const chip_ch32v203x8 = chip_ch32v20x_base.create(dep, mem_64k_20k);
    const chip_ch32v203xb = chip_ch32v20x_base.create(dep, mem_128k_64k);
    const chip_ch32v208xb = chip_ch32v20x_base.create(dep, mem_128k_64k);
    const chip_ch32v303xb = chip_ch32v30x_base.create(dep, mem_128k_32k);
    const chip_ch32v303xc = chip_ch32v30x_base.create(dep, mem_256k_64k);
    const chip_ch32v305xb = chip_ch32v30x_base.create(dep, mem_128k_32k);
    const chip_ch32v307xc = chip_ch32v30x_base.create(dep, mem_256k_64k);

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

    const board_nano_ch32v305 = chip_ch32v305xb.derive(.{
        .board = .{
            .name = "WCH nanoCH32V305",
            .url = "https://github.com/wuxx/nanoCH32V305",
            .root_source_file = b.path("src/boards/nanoCH32V305.zig"),
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
            .ch32v003x4 = chip_ch32v003x4,
            .ch32v103x6 = chip_ch32v103x6,
            .ch32v103x8 = chip_ch32v103x8,
            .ch32v203x6 = chip_ch32v203x6,
            .ch32v203x8 = chip_ch32v203x8,
            .ch32v203xb = chip_ch32v203xb,
            .ch32v208xb = chip_ch32v208xb,
            .ch32v303xb = chip_ch32v303xb,
            .ch32v303xc = chip_ch32v303xc,
            .ch32v305xb = chip_ch32v305xb,
            .ch32v307xc = chip_ch32v307xc,
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
            .ch32v305 = .{
                .nano_ch32v305 = board_nano_ch32v305,
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
