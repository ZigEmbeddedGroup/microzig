const std = @import("std");

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const hal = .{
    .source_file = path("/src/hals/GD32VF103.zig"),
};

pub const chips = struct {
    pub const gd32vf103xb = .{
        .preferred_format = .elf,
        .chip = .{
            .name = "GD32VF103",
            .cpu = .riscv32_imac,
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

    pub const gd32vf103x8 = .{
        .preferred_format = .elf,
        .chip = .{
            .name = "GD32VF103",
            .cpu = .riscv32_imac,
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
        pub const longan_nano = .{
            .preferred_format = .elf,
            .chip = chips.gd32vf103xb.chip,
            .hal = hal,
            .board = .{
                .name = "Longan Nano",
                .url = "https://longan.sipeed.com/en/",
                .source_file = path("/src/boards/longan_nano.zig"),
            },
        };
    };
};

pub fn build(b: *std.build.Builder) void {
    _ = b;
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
}
