const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    //MCX-A 153/152/143/142/132/133
    mcxa153: *const microzig.Target,

    //MCX-A 154/155/156/144/145/146
    //mcxa144: *const microzig.Target, TODO
    //mcxa145: *const microzig.Target, TODO
    //mcxa146: *const microzig.Target, TODO
    mcxa154: *const microzig.Target,
    mcxa155: *const microzig.Target,
    mcxa156: *const microzig.Target,

    //MCX-N low density
    //mcxn256: *const microzig.Target, //TODO

    //MCX-N HIGH density
    mcxn947: *const microzig.Target,
},

boards: struct {
    frdm_mcxa153: *const microzig.Target,
    frdm_mcxa156: *const microzig.Target,
    frdm_mcxn947: *const microzig.Target,
},

pub fn init(dep: *std.Build.Dependency) ?Self {
    const b = dep.builder;

    const mcux_soc_svd = b.lazyDependency("mcux-soc-svd", .{}) orelse return null;

    const chip_mcxa154: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabihf,
        },
        .chip = .{
            .name = "MCXA154",
            .register_definition = .{ .svd = mcux_soc_svd.path("MCXA154/MCXA154.xml") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 256 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 64 * 1024, .access = .rw },
                .{ .tag = .ram, .offset = 0x2001E000, .length = 8 * 1024, .access = .rw, .name = "ECC" },
            },
        },
        .hal = .{ .root_source_file = b.path("src/mcxa_15x/hal.zig") },
    };

    const chip_mcxa155: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabihf,
        },
        .chip = .{
            .name = "MCXA155",
            .register_definition = .{ .svd = mcux_soc_svd.path("MCXA155/MCXA155.xml") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 512 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 96 * 1024, .access = .rw },
                .{ .tag = .ram, .offset = 0x2001E000, .length = 8 * 1024, .access = .rw, .name = "ECC" },
            },
        },
        .hal = .{ .root_source_file = b.path("src/mcxa_15x/hal.zig") },
    };

    const chip_mcxa156: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "MCXA156",
            .register_definition = .{ .svd = mcux_soc_svd.path("MCXA156/MCXA156.xml") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 1024 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 120 * 1024, .access = .rw },
                .{ .tag = .ram, .offset = 0x2001E000, .length = 8 * 1024, .access = .rw, .name = "ECC" },
            },
        },
        .hal = .{ .root_source_file = b.path("src/mcxa_15x/hal.zig") },
    };

    const chip_mcxa153: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "MCXA153",
            .register_definition = .{ .svd = mcux_soc_svd.path("MCXA153/MCXA153.xml") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 128 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 24 * 1024, .access = .rw },
            },
        },
        .hal = .{ .root_source_file = b.path("src/mcxa153/hal.zig") },
    };

    const chip_mcxn947: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{ .cpu_arch = .thumb, .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 }, .os_tag = .freestanding, .abi = .eabi },
        .chip = .{
            // TODO: handle other core
            .name = "MCXN947_cm33_core0",
            .register_definition = .{ .svd = mcux_soc_svd.path("MCXN947/MCXN947_cm33_core0.xml") },
            .memory_regions = &.{
                // TODO: not sure about the accesses
                // TODO: ROM
                // TODO: secure vs non-secure
                .{ .tag = .flash, .offset = 0x00000000, .length = 2 * 1024 * 1024, .access = .rx },
                // .{ .tag = .ram, .offset = 0x04000000, .length =  96 * 1024, .access = .rwx, .name = "RAMX" },
                .{ .tag = .ram, .offset = 0x20000000, .length = 416 * 1024, .access = .rwx, .name = "RAMA-H" },
                // .{ .tag = .ram, .offset = 0x13000000, .length = 256 * 1024, .access = .r,   .name = "ROM" },
            },
        },
        // TODO: not need that ?
        .stack = .{ .symbol_name = "end_of_stack" },
        .linker_script = .{ .generate = .none, .file = b.path("linker.ld") },
        .hal = .{ .root_source_file = b.path("src/mcxn947/hal/hal.zig") },
    };

    return .{
        .chips = .{
            .mcxa153 = chip_mcxa153.derive(.{}),
            .mcxa154 = chip_mcxa154.derive(.{}),
            .mcxa155 = chip_mcxa155.derive(.{}),
            .mcxa156 = chip_mcxa156.derive(.{}),
            .mcxn947 = chip_mcxn947.derive(.{}),
        },
        .boards = .{
            .frdm_mcxa153 = chip_mcxa153.derive(.{
                .board = .{
                    .name = "FRDM Development Board for MCX A153",
                    .url = "https://www.nxp.com/part/FRDM-MCXA153",
                    .root_source_file = b.path("src/boards/frdm_mcxa153.zig"),
                },
            }),
            .frdm_mcxn947 = chip_mcxn947.derive(.{
                .board = .{
                    .name = "FRDM Development Board for MCX N947",
                    .url = "https://www.nxp.com/part/FRDM-MCXN947",
                    .root_source_file = b.path("src/boards/frdm_mcxn947.zig"),
                },
            }),
            .frdm_mcxa156 = chip_mcxa156.derive(.{
                .board = .{
                    .name = "FRDM Development Board for MCX A156",
                    .url = "https://www.nxp.com/part/FRDM-MCXA156",
                    .root_source_file = b.path("src/boards/frdm_mcxa156.zig"),
                },
            }),
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
