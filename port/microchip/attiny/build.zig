const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    attiny85: *const microzig.Target,
    attiny84: *const microzig.Target,
},

boards: struct {
    digispark: *const microzig.Target,
    adafruit: struct {
        trinket: *const microzig.Target,
        gemma: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const atpack = b.dependency("atpack", .{});

    const avr25_target: std.Target.Query = .{
        .cpu_arch = .avr,
        .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr25 },
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const chip_attiny85: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .hex,
        .zig_target = avr25_target,
        .chip = .{
            .name = "ATtiny85",
            .url = "https://www.microchip.com/en-us/product/attiny85",
            .register_definition = .{
                .atdf = atpack.path("atdf/ATtiny85.atdf"),
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x000000, .length = 8 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x800060, .length = 512, .access = .rw },
            },
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ATtiny85.zig"),
        },
        .bundle_compiler_rt = false,
    };

    const chip_attiny84: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .hex,
        .zig_target = avr25_target,
        .chip = .{
            .name = "ATtiny84",
            .url = "https://www.microchip.com/en-us/product/attiny84",
            .register_definition = .{
                .atdf = atpack.path("atdf/ATtiny84.atdf"),
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x000000, .length = 8 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x800060, .length = 512, .access = .rw },
            },
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ATtiny84.zig"),
        },
        .bundle_compiler_rt = false,
    };

    return .{
        .chips = .{
            .attiny85 = chip_attiny85.derive(.{}),
            .attiny84 = chip_attiny84.derive(.{}),
        },
        .boards = .{
            .digispark = chip_attiny85.derive(.{
                .board = .{
                    .name = "Digispark",
                    .url = "http://digistump.com/products/1",
                    .root_source_file = b.path("src/boards/digispark.zig"),
                },
            }),
            .adafruit = .{
                .trinket = chip_attiny85.derive(.{
                    .board = .{
                        .name = "Adafruit Trinket",
                        .url = "https://www.adafruit.com/product/1501",
                        .root_source_file = b.path("src/boards/adafruit_trinket.zig"),
                    },
                }),
                .gemma = chip_attiny85.derive(.{
                    .board = .{
                        .name = "Adafruit Gemma",
                        .url = "https://www.adafruit.com/product/1222",
                        .root_source_file = b.path("src/boards/adafruit_gemma.zig"),
                    },
                }),
            },
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
