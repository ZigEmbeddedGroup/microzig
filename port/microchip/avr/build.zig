const std = @import("std");
const Build = std.Build;
const MicroZig = @import("microzig/build");

fn path(comptime suffix: []const u8) Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const hal = .{
    .root_source_file = path("/src/hals/ATmega328P.zig"),
};
const hal32u4 = .{
    .root_source_file = path("/src/hals/ATmega32U4.zig"),
};

pub const chips = struct {
    pub const atmega328p = MicroZig.Target{
        .preferred_format = .hex,
        .chip = .{
            .name = "ATmega328P",
            .url = "https://www.microchip.com/en-us/product/atmega328p",
            .cpu = MicroZig.cpus.avr5,
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
    pub const atmega32u4 = MicroZig.Target{
        .preferred_format = .hex,
        .chip = .{
            .name = "ATmega32U4",
            .url = "https://www.microchip.com/en-us/product/ATmega32U4",
            .cpu = MicroZig.cpus.avr5,
            .register_definition = .{
                .json = path("/src/chips/ATmega32U4.json"),
            },
            .memory_regions = &.{
                .{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
                .{ .offset = 0x800100, .length = 2560, .kind = .ram },
            },
        },
        .hal = hal32u4,
    };
};

pub const boards = struct {
    pub const arduino = struct {
        pub const nano = MicroZig.Target{
            .preferred_format = .hex,
            .chip = chips.atmega328p.chip,
            .hal = hal,
            .board = .{
                .name = "Arduino Nano",
                .url = "https://docs.arduino.cc/hardware/nano",
                .root_source_file = path("/src/boards/arduino_nano.zig"),
            },
        };

        pub const uno_rev3 = MicroZig.Target{
            .preferred_format = .hex,
            .chip = chips.atmega328p.chip,
            .hal = hal,
            .board = .{
                .name = "Arduino Uno",
                .url = "https://docs.arduino.cc/hardware/uno-rev3",
                .root_source_file = path("/src/boards/arduino_uno.zig"),
            },
        };
    };
    pub const adafruit = struct {
        pub const itsybitsy_32u4 = MicroZig.Target{
            .preferred_format = .hex,
            .chip = chips.atmega32u4.chip,
            .hal = hal32u4,
            .board = .{
                .name = "Adafruit ItsyBitsy 32u4",
                .url = "https://cdn-learn.adafruit.com/downloads/pdf/introducting-itsy-bitsy-32u4.pdf",
                .root_source_file = path("/src/boards/itsybitsy_32u4.zig"),
            },
        };
    };
};

pub fn build(b: *Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
