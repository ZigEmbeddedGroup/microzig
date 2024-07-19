const std = @import("std");
const MicroZig = @import("microzig/build");

const KiB = 1024;

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const wch_qingke_v2 = .{
    .name = "WCH QingKe V2",
    .root_source_file = path("/src/cpus/wch_qingke_v2.zig"),
    .target = std.Target.Query{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.e,
            std.Target.riscv.Feature.c,
        }),
        .os_tag = .freestanding,
        .abi = .eabi,
    },
};

pub const chips = struct {
    pub const ch32v003xx = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "CH32V00xxx",
            .cpu = wch_qingke_v2,
            .memory_regions = &.{
                .{ .offset = 0x0800_0000, .length = 16 * KiB, .kind = .flash },
                .{ .offset = 0x2000_0000, .length = 2 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .svd = path("/src/chips/CH32V00xxx.svd"),
            },
        },
        .hal = .{
            .root_source_file = path("/src/hals/CH32V003xx.zig"),
        },
    };
};

pub const boards = struct {};

pub fn build(b: *std.Build) !void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
