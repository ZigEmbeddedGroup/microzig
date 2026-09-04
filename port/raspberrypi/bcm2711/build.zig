const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    bcm2711: *const microzig.Target,
},

boards: struct {
    raspberrypi: struct {
        pi_4b: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) ?Self {
    const b = dep.builder;

    const bcm2711_zig_target: std.Target.Query = .{
        .cpu_arch = .aarch64,
        .cpu_model = .{ .explicit = &std.Target.aarch64.cpu.cortex_a72 },
        // Floating point and SIMD are trapped until CPACR_EL1 or CPTR_EL2 says otherwise, and
        // this port does not set those up, so keep the compiler out of those registers.
        .cpu_features_sub = std.Target.aarch64.featureSet(&.{
            .fp_armv8,
            .neon,
        }),
        .os_tag = .freestanding,
        .abi = .none,
    };

    const chip_bcm2711: microzig.Target = .{
        .dep = dep,
        .zig_target = bcm2711_zig_target,
        // The firmware reads kernel8.img off the boot partition into ram and jumps to it, there
        // is no flash for the image to be copied out of.
        .ram_image = true,
        .preferred_binary_format = .binary,
        .entry = .{ .symbol_name = "_start" },
        .cpu = .{
            .name = "cortex_a72",
            .root_source_file = b.path("src/cpus/cortex_a72.zig"),
        },
        .chip = .{
            .name = "BCM2711",
            .url = "https://www.raspberrypi.com/documentation/computers/processors.html#bcm2711",
            // Broadcom publishes no svd for this part, the registers this port uses are written
            // out by hand.
            .register_definition = .{ .zig = b.path("src/chips/BCM2711.zig") },
            .memory_regions = &.{
                // The firmware loads the image at 0x80000. Every Raspberry Pi 4 model has at
                // least a gigabyte, but 128 MiB is all this port lays claim to; the stack sits
                // at the top of it.
                .{ .name = "RAM", .tag = .ram, .offset = 0x8_0000, .length = 0x800_0000, .access = .rwx },
            },
        },
        .hal = .{
            .root_source_file = b.path("src/hal.zig"),
        },
        .linker_script = .{
            .generate = .memory_regions,
            .file = b.path("ld/kernel8_sections.ld"),
        },
    };

    return .{
        .chips = .{
            .bcm2711 = chip_bcm2711.derive(.{}),
        },
        .boards = .{
            .raspberrypi = .{
                .pi_4b = chip_bcm2711.derive(.{
                    .board = .{
                        .name = "Raspberry Pi 4 Model B",
                        .url = "https://www.raspberrypi.com/products/raspberry-pi-4-model-b/",
                        .root_source_file = b.path("src/boards/raspberry_pi_4b.zig"),
                    },
                }),
            },
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
