const std = @import("std");
const Build = std.Build;

const MicroZig = @import("build/definitions");

// TODO: fix this issue with AVR. For some reason we fail wasi assertions?
//
// error: the following command failed with 1 compilation errors:
//Users/mattnite/zig/0.12.0-dev.3097+5c0766b6c/files/zig build-exe -freference-trace=256 -OReleaseSmall -target avr-freestanding-eabi -mcpu avr5 --dep app --dep microzig -Mroot=/Users/mattnite/code/microzig/core/src/start.zig --dep microzig -Mapp=/Users/mattnite/code/microzig/examples/microchip/avr/src/blinky.zig --dep config --dep chip --dep cpu --dep hal --dep board -Mmicrozig=/Users/mattnite/code/microzig/core/src/microzig.zig -Mconfig=/Users/mattnite/code/microzig/zig-cache/c/303c67fccae4ec4bb03ec2180082b67b/options.zig --dep microzig -Mchip=/Users/mattnite/code/microzig/zig-cache/o/2c86b0de714a8b4409eb761d16297c00/chip.zig --dep microzig -Mcpu=/Users/mattnite/code/microzig/core/src/cpus/avr5.zig --dep microzig -Mhal=/Users/mattnite/code/microzig/bsp/microchip/avr/src/hals/ATmega328P.zig --dep microzig -Mboard=/Users/mattnite/code/microzig/bsp/microchip/avr/src/boards/arduino_uno.zig --cache-dir /Users/mattnite/code/microzig/zig-cache --global-cache-dir /Users/mattnite/.cache/zig --name arduino-nano_blinky -static -fcompiler-rt --script /Users/mattnite/code/microzig/zig-cache/o/2c186d936508aa71bea517796451c3f9/linker.ld --listen=-
//install
//mq install
//   mq install generated to arduino-nano_blinky.hex
//      mq objcopy generated
//         mq zig build-exe arduino-nano_blinky ReleaseSmall avr-freestanding-eabi 1 errors
///Users/mattnite/zig/0.12.0-dev.3097+5c0766b6c/files/lib/std/debug.zig:403:14: error: reached unreachable code
//    if (!ok) unreachable; // assertion failure
//             ^~~~~~~~~~~
///Users/mattnite/zig/0.12.0-dev.3097+5c0766b6c/files/lib/std/os/wasi.zig:12:11: note: called from here
//    assert(@alignOf(i16) == 2);
//    ~~~~~~^~~~~~~~~~~~~~~~~~~~
const example_dep_names: []const []const u8 = &.{
    "examples/nordic/nrf5x",
    "examples/nxp/lpc",
    "examples/microchip/atsam",
    //"examples/microchip/avr",
    "examples/gigadevice/gd32",
    "examples/stmicro/stm32",
    "examples/espressif/esp",
    "examples/raspberrypi/rp2040",
};

const bsps = .{
    .{ "bsp/nordic/nrf5x", @import("bsp/nordic/nrf5x") },
    .{ "bsp/nxp/lpc", @import("bsp/nxp/lpc") },
    .{ "bsp/microchip/atsam", @import("bsp/microchip/atsam") },
    .{ "bsp/microchip/avr", @import("bsp/microchip/avr") },
    .{ "bsp/gigadevice/gd32", @import("bsp/gigadevice/gd32") },
    .{ "bsp/stmicro/stm32", @import("bsp/stmicro/stm32") },
    .{ "bsp/espressif/esp", @import("bsp/espressif/esp") },
    .{ "bsp/raspberrypi/rp2040", @import("bsp/raspberrypi/rp2040") },
};

pub fn build(b: *Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // Build all examples
    for (example_dep_names) |example_dep_name| {
        const example_dep = b.dependency(example_dep_name, .{
            .optimize = optimize,
        });

        const example_dep_install_step = example_dep.builder.getInstallStep();
        b.getInstallStep().dependOn(example_dep_install_step);
    }

    const boxzer_dep = b.dependency("boxzer", .{});
    const boxzer_exe = boxzer_dep.artifact("boxzer");
    const boxzer_run = b.addRunArtifact(boxzer_exe);
    if (b.args) |args|
        boxzer_run.addArgs(args);

    const package_step = b.step("package", "Package monorepo using boxzer");
    package_step.dependOn(&boxzer_run.step);

    //const website_dep = b.dependency("website", .{});
    //const website_step = b.step("website", "Build website");
    //website_step.dependOn(website_dep.builder.getInstallStep());

    const parts_db = generate_parts_db(b) catch @panic("OOM");
    const parts_db_json = b.addInstallFile(parts_db, "parts-db.json");
    package_step.dependOn(&parts_db_json.step);
}

const PartsDb = struct {
    chips: []const Chip,
    boards: []const Board,

    const Chip = struct {
        identifier: []const u8,
        bsp_package: []const u8,
        url: ?[]const u8,
        cpu: []const u8,
        has_hal: bool,
        memory: struct {
            flash: u64,
            ram: u64,
        },
        output_format: ?[]const u8,
    };
    const Board = struct {
        identifier: []const u8,
        bsp_package: []const u8,
        chip_idx: u32,
        url: ?[]const u8,
        output_format: ?[]const u8,
    };
};

fn generate_parts_db(b: *Build) !Build.LazyPath {
    var chips = std.ArrayList(PartsDb.Chip).init(b.allocator);
    var boards = std.ArrayList(PartsDb.Board).init(b.allocator);
    inline for (bsps) |bsp| {
        const chips_start_idx = chips.items.len;
        inline for (@typeInfo(@field(bsp[1], "chips")).Struct.decls) |decl| {
            const target = @field(@field(bsp[1], "chips"), decl.name);
            try chips.append(.{
                .identifier = decl.name,
                .bsp_package = bsp[0],
                .url = target.chip.url,
                .cpu = target.chip.cpu.name,
                .has_hal = target.hal != null,
                .memory = .{
                    .flash = 0,
                    .ram = 0,
                },
                .output_format = null,
            });
        }

        inline for (@typeInfo(@field(bsp[1], "boards")).Struct.decls) |decl| {
            const target = @field(@field(bsp[1], "boards"), decl.name);
            _ = target;
            _ = chips_start_idx;

            //const chip_idx = inline for (@typeInfo(@field(bsp[1], "chips")).Struct.decls, 0..) |chip_decl, idx| {
            //    const chip = @field(@field(bsp[1], "chips"), chip_decl.name);
            //    if (std.mem.eql(u8, chip.chip.name, target.chip.name))
            //        break chips_start_idx + idx;
            //} else @compileError("failed to get chip_idx");

            try boards.append(.{
                .identifier = decl.name,
                .bsp_package = bsp[0],
                .chip_idx = 0,
                .url = "",
                .output_format = null,
            });
        }
    }

    const parts_db = PartsDb{
        .chips = chips.items,
        .boards = boards.items,
    };

    const parts_db_str = try std.json.stringifyAlloc(b.allocator, parts_db, .{
        .whitespace = .indent_4,
    });
    const write_file_step = b.addWriteFiles();
    return write_file_step.add("parts-db.json", parts_db_str);
}
