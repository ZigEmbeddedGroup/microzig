const std = @import("std");
const Build = std.Build;
const MicroZig = @import("microzig/build");

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const hal = .{
    .root_source_file = path("/src/hals/GD32VF103/hal.zig"),
};

pub const chips = struct {
    pub const gd32vf103xb = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "GD32VF103",
            .cpu = MicroZig.cpus.riscv32_imac,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 128 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 32 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .json = path("/src/chips/GD32VF103.json"),
            },
        },
        .hal = hal,
    };

    pub const gd32vf103x8 = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "GD32VF103",
            .cpu = MicroZig.cpus.riscv32_imac,
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .json = path("/src/chips/GD32VF103.json"),
            },
        },
        .hal = hal,
    };
};

pub const boards = struct {
    pub const sipeed = struct {
        pub const longan_nano = MicroZig.Target{
            .preferred_format = .elf,
            .chip = chips.gd32vf103xb.chip,
            .hal = hal,
            .board = .{
                .name = "Longan Nano",
                .url = "https://longan.sipeed.com/en/",
                .root_source_file = path("/src/boards/longan_nano.zig"),
            },
        };
    };
};

pub fn build(b: *Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
