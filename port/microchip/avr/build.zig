const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    atmega328p: *const microzig.Target,
    atmega32u4: *const microzig.Target,
},

boards: struct {
    arduino: struct {
        nano: *const microzig.Target,
        uno_rev3: *const microzig.Target,
    },
    adafruit: struct {
        itsybitsy_32u4: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const avr5_target: std.Target.Query = .{
        .cpu_arch = .avr,
        .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const chip_atmega328p: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .hex,
        .zig_target = avr5_target,
        .chip = .{
            .name = "ATmega328P",
            .url = "https://www.microchip.com/en-us/product/atmega328p",
            .register_definition = .{
                .atdf = b.path("src/chips/ATmega328P.atdf"),
            },
            .memory_regions = &.{
                .{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
                .{ .offset = 0x800100, .length = 2048, .kind = .ram },
            },
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ATmega328P.zig"),
        },
    };

    const chip_atmega32u4: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .hex,
        .zig_target = avr5_target,
        .chip = .{
            .name = "ATmega32U4",
            .url = "https://www.microchip.com/en-us/product/ATmega32U4",
            .register_definition = .{
                .atdf = b.path("src/chips/ATmega32U4.atdf"),
            },
            .memory_regions = &.{
                .{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
                .{ .offset = 0x800100, .length = 2560, .kind = .ram },
            },
        },
        .hal = .{
            .root_source_file = b.path("src/hals/ATmega32U4.zig"),
        },
    };

    return .{
        .chips = .{
            .atmega328p = chip_atmega328p.derive(.{}),
            .atmega32u4 = chip_atmega32u4.derive(.{}),
        },
        .boards = .{
            .arduino = .{
                .nano = chip_atmega328p.derive(.{
                    .board = .{
                        .name = "Arduino Nano",
                        .url = "https://docs.arduino.cc/hardware/nano",
                        .root_source_file = b.path("src/boards/arduino_nano.zig"),
                    },
                }),
                .uno_rev3 = chip_atmega328p.derive(.{
                    .board = .{
                        .name = "Arduino Nano",
                        .url = "https://docs.arduino.cc/hardware/nano",
                        .root_source_file = b.path("src/boards/arduino_uno.zig"),
                    },
                }),
            },
            .adafruit = .{
                .itsybitsy_32u4 = chip_atmega32u4.derive(.{
                    .board = .{
                        .name = "Arduino Nano",
                        .url = "https://docs.arduino.cc/hardware/nano",
                        .root_source_file = b.path("src/boards/itsybitsy_32u4.zig"),
                    },
                }),
            },
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
