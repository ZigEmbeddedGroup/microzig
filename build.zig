const std = @import("std");
const Build = std.Build;
const comptimePrint = std.fmt.comptimePrint;

const microzig = @import("microzig");

pub const chips = @import("src/chips.zig");
pub const boards = @import("src/boards.zig");

const build_root = root();

const linkerscript_path = build_root ++ "/rp2040.ld";

pub const BootROM = union(enum) {
    artifact: *std.build.CompileStep, // provide a custom startup code
    blob: std.build.LazyPath, // just include a binary blob

    // Pre-shipped ones:
    at25sf128a,
    generic_03h,
    is25lp080,
    w25q080,
    w25x10cl,

    // Use the old stage2 bootloader vendored with MicroZig till 2023-09-13
    legacy,
};

pub const PicoExecutableOptions = struct {
    name: []const u8,
    source_file: std.Build.LazyPath,
    optimize: std.builtin.OptimizeMode = .Debug,

    board: boards.Board = boards.raspberry_pi_pico,

    bootrom: ?BootROM = null,
};

pub const addPiPicoExecutable = addExecutable; // Deprecated, use addExecutable!

pub const Stage2Bootloader = struct {
    bin: std.Build.LazyPath,
    elf: ?std.Build.LazyPath,
};

pub fn getBootrom(b: *Build, rom: BootROM) Stage2Bootloader {
    const rom_exe = switch (rom) {
        .artifact => |artifact| artifact,
        .blob => |blob| return Stage2Bootloader{
            .bin = blob,
            .elf = null,
        },

        else => blk: {
            var target = chips.rp2040.cpu.target;
            target.abi = .eabi;

            const rom_path = b.pathFromRoot(b.fmt("{s}/src/bootroms/{s}.S", .{ build_root, @tagName(rom) }));

            const rom_exe = b.addExecutable(.{
                .name = b.fmt("stage2-{s}", .{@tagName(rom)}),
                .optimize = .ReleaseSmall,
                .target = target,
                .root_source_file = null,
            });
            rom_exe.linkage = .static;
            // rom_exe.pie = false;
            // rom_exe.force_pic = false;
            rom_exe.setLinkerScript(.{ .path = build_root ++ "/src/bootroms/shared/stage2.ld" });
            rom_exe.addAssemblyFile(.{ .path = rom_path });

            break :blk rom_exe;
        },
    };

    const rom_objcopy = b.addObjCopy(rom_exe.getEmittedBin(), .{
        .basename = b.fmt("{s}.bin", .{@tagName(rom)}),
        .format = .bin,
    });

    return Stage2Bootloader{
        .bin = rom_objcopy.getOutput(),
        .elf = rom_exe.getEmittedBin(),
    };
}

pub fn addExecutable(
    b: *Build,
    opts: PicoExecutableOptions,
) *microzig.EmbeddedExecutable {
    var exe = microzig.addEmbeddedExecutable(b, .{
        .name = opts.name,
        .source_file = opts.source_file,
        .backing = .{ .board = opts.board.inner },
        .optimize = opts.optimize,
        .linkerscript_source_file = .{ .path = linkerscript_path },
    });

    const i: *std.Build.CompileStep = exe.inner;

    const bootrom_file = getBootrom(b, opts.bootrom orelse opts.board.bootrom);

    // HACK: Inject the file as a dependency to MicroZig.board
    i.modules.get("microzig").?.dependencies.get("board").?.dependencies.put(
        "bootloader",
        b.createModule(.{
            .source_file = bootrom_file.bin,
        }),
    ) catch @panic("oom");
    bootrom_file.bin.addStepDependencies(&i.step);

    return exe;
}

// this build script is mostly for testing and verification of this
// package. In an attempt to modularize -- designing for a case where a
// project requires multiple HALs, it accepts microzig as a param
pub fn build(b: *Build) !void {
    const optimize = b.standardOptimizeOption(.{});

    const args_dep = b.dependency("args", .{});
    const args_mod = args_dep.module("args");

    var examples = Examples.init(b, optimize);
    examples.install(b);

    const pio_tests = b.addTest(.{
        .root_source_file = .{
            .path = "src/hal.zig",
        },
        .optimize = optimize,
    });
    pio_tests.addIncludePath(.{ .path = "src/hal/pio/assembler" });

    const test_step = b.step("test", "run unit tests");
    test_step.dependOn(&b.addRunArtifact(pio_tests).step);

    {
        const flash_tool = b.addExecutable(.{
            .name = "rp2040-flash",
            .optimize = .Debug,
            .target = .{},
            .root_source_file = .{ .path = "tools/rp2040-flash.zig" },
        });
        flash_tool.addModule("args", args_mod);

        b.installArtifact(flash_tool);
    }

    // Install all bootroms for debugging and CI
    inline for (comptime std.enums.values(std.meta.Tag(BootROM))) |rom| {
        if (rom == .artifact or rom == .blob) {
            continue;
        }

        if (rom == .is25lp080) {
            // TODO: https://github.com/ZigEmbeddedGroup/raspberrypi-rp2040/issues/79
            //  is25lp080.o:(text+0x16): has non-ABS relocation R_ARM_THM_CALL against symbol 'read_flash_sreg'
            continue;
        }

        const files = getBootrom(b, rom);
        if (files.elf) |elf| {
            b.getInstallStep().dependOn(
                &b.addInstallFileWithDir(elf, .{ .custom = "stage2" }, b.fmt("{s}.elf", .{@tagName(rom)})).step,
            );
        }
        b.getInstallStep().dependOn(
            &b.addInstallFileWithDir(files.bin, .{ .custom = "stage2" }, b.fmt("{s}.bin", .{@tagName(rom)})).step,
        );
    }
}

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".") ++ "/";
}

pub const Examples = struct {
    adc: *microzig.EmbeddedExecutable,
    blinky: *microzig.EmbeddedExecutable,
    blinky_core1: *microzig.EmbeddedExecutable,
    gpio_clk: *microzig.EmbeddedExecutable,
    i2c_bus_scan: *microzig.EmbeddedExecutable,
    pwm: *microzig.EmbeddedExecutable,
    spi_master: *microzig.EmbeddedExecutable,
    uart: *microzig.EmbeddedExecutable,
    squarewave: *microzig.EmbeddedExecutable,
    //uart_pins: microzig.EmbeddedExecutable,
    flash_program: *microzig.EmbeddedExecutable,
    usb_device: *microzig.EmbeddedExecutable,
    usb_hid: *microzig.EmbeddedExecutable,
    ws2812: *microzig.EmbeddedExecutable,
    random: *microzig.EmbeddedExecutable,

    pub fn init(b: *Build, optimize: std.builtin.OptimizeMode) Examples {
        var ret: Examples = undefined;
        inline for (@typeInfo(Examples).Struct.fields) |field| {
            const path = comptime root() ++ "examples/" ++ field.name ++ ".zig";

            @field(ret, field.name) = addExecutable(b, .{
                .name = field.name,
                .source_file = .{ .path = path },
                .optimize = optimize,
            });
        }

        return ret;
    }

    pub fn install(examples: *Examples, b: *Build) void {
        inline for (@typeInfo(Examples).Struct.fields) |field| {
            b.getInstallStep().dependOn(
                &b.addInstallFileWithDir(@field(examples, field.name).inner.getEmittedBin(), .{ .custom = "firmware" }, field.name ++ ".elf").step,
            );
        }
    }
};
