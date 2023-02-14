const std = @import("std");
const Builder = std.build.Builder;
const Pkg = std.build.Pkg;
const comptimePrint = std.fmt.comptimePrint;

pub const microzig = @import("deps/microzig/src/main.zig");

const chip_path = comptimePrint("{s}/src/rp2040.zig", .{root()});
const board_path = comptimePrint("{s}/src/raspberry_pi_pico.zig", .{root()});
const hal_path = comptimePrint("{s}/src/hal.zig", .{root()});
const linkerscript_path = comptimePrint("{s}/rp2040.ld", .{root()});

pub const BuildOptions = struct {
    optimize: std.builtin.OptimizeMode,
};

pub fn addPiPicoExecutable(
    builder: *Builder,
    name: []const u8,
    source: []const u8,
    options: BuildOptions,
) microzig.EmbeddedExecutable {
    const rp2040 = microzig.Chip{
        .name = "RP2040",
        .path = chip_path,
        .cpu = microzig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
            .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
            .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
        },
    };

    const raspberry_pi_pico = microzig.Board{
        .name = "Raspberry Pi Pico",
        .path = board_path,
        .chip = rp2040,
    };

    const ret = microzig.addEmbeddedExecutable(
        builder,
        name,
        source,
        .{ .board = raspberry_pi_pico },
        .{
            .optimize = options.optimize,
            .hal_module_path = .{ .path = hal_path },
        },
    );
    ret.inner.setLinkerScriptPath(.{ .path = linkerscript_path });

    return ret;
}

// this build script is mostly for testing and verification of this
// package. In an attempt to modularize -- designing for a case where a
// project requires multiple HALs, it accepts microzig as a param
pub fn build(b: *Builder) !void {
    const optimize = b.standardOptimizeOption(.{});
    var examples = Examples.init(b, optimize);
    examples.install();
}

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub const Examples = struct {
    adc: microzig.EmbeddedExecutable,
    blinky: microzig.EmbeddedExecutable,
    blinky_core1: microzig.EmbeddedExecutable,
    gpio_clk: microzig.EmbeddedExecutable,
    pwm: microzig.EmbeddedExecutable,
    uart: microzig.EmbeddedExecutable,
    //uart_pins: microzig.EmbeddedExecutable,

    pub fn init(b: *Builder, optimize: std.builtin.OptimizeMode) Examples {
        var ret: Examples = undefined;
        inline for (@typeInfo(Examples).Struct.fields) |field| {
            @field(ret, field.name) = addPiPicoExecutable(
                b,
                field.name,
                comptime root() ++ "/examples/" ++ field.name ++ ".zig",
                .{ .optimize = optimize },
            );
        }

        return ret;
    }

    pub fn install(examples: *Examples) void {
        inline for (@typeInfo(Examples).Struct.fields) |field|
            @field(examples, field.name).install();
    }
};
