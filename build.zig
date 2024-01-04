const std = @import("std");

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const hal = .{
    .source_file = path("/src/hals/ATmega328P.zig"),
};

pub const chips = struct {
    pub const atmega328p = .{
        .preferred_format = .hex,
        .chip = .{
            .name = "ATmega328P",
            .url = "https://www.microchip.com/en-us/product/atmega328p",
            .cpu = .avr5,
            .register_definition = .{
                .json = path("/src/chips/ATmega328P.json"),
            },
            .memory_regions = &.{
                .{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
                .{ .offset = 0x800100, .length = 2048, .kind = .ram },
            },
        },
        .hal = hal,
    };
};

pub const boards = struct {
    pub const arduino = struct {
        pub const nano = .{
            .preferred_format = .hex,
            .chip = chips.atmega328p.chip,
            .hal = hal,
            .board = .{
                .name = "Arduino Nano",
                .url = "https://docs.arduino.cc/hardware/nano",
                .source_file = path("/src/boards/arduino_nano.zig"),
            },
        };

        pub const uno_rev3 = .{
            .preferred_format = .hex,
            .chip = chips.atmega328p.chip,
            .hal = hal,
            .board = .{
                .name = "Arduino Uno",
                .url = "https://docs.arduino.cc/hardware/uno-rev3",
                .source_file = path("/src/boards/arduino_uno.zig"),
            },
        };
    };
};

pub fn build(b: *std.build.Builder) void {
    _ = b;
    // const optimize = b.standardOptimizeOption(.{});
    // inline for (@typeInfo(boards).Struct.decls) |decl| {
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
