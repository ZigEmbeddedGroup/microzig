const std = @import("std");
const MicroZig = @import("microzig-build");

pub const microzig_board_support = MicroZig.registerBoardSupport(@This());

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

pub const chips = struct {
    pub const nrf52840 = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "nrf52840",
            .url = "https://www.nordicsemi.com/products/nrf52840",
            .cpu = .cortex_m4,
            .register_definition = .{
                .json = path("/src/chips/nrf52840.json"),
            },
            .memory_regions = &.{
                .{ .offset = 0x00000000, .length = 0x100000, .kind = .flash },
                .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },

                // EXTFLASH
                .{ .offset = 0x12000000, .length = 0x8000000, .kind = .flash },

                // CODE_RAM
                .{ .offset = 0x800000, .length = 0x40000, .kind = .ram },
            },
        },
    };

    pub const nrf52832 = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "nrf52",
            .url = "https://www.nordicsemi.com/products/nrf52832",
            .cpu = .cortex_m4,
            .register_definition = .{
                .json = path("/src/chips/nrf52.json"),
            },
            .memory_regions = &.{
                .{ .offset = 0x00000000, .length = 0x80000, .kind = .flash },
                .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            },
        },
    };
};

pub const boards = struct {
    pub const nordic = struct {
        pub const nRF52840_Dongle = MicroZig.Target{
            .preferred_format = .elf,
            .chip = chips.nrf52840.chip,
            .board = .{
                .name = "nRF52840 Dongle",
                .url = "https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dongle",
                .source_file = path("/src/boards/nrf52840-dongle.zig"),
            },
        };
    };
};

pub fn build(b: *std.build.Builder) void {
    _ = b;
}
