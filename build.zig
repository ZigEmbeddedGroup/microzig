const std = @import("std");
const Builder = std.build.Builder;
const Pkg = std.build.Pkg;
const comptimePrint = std.fmt.comptimePrint;
const FileSource = std.build.FileSource;

pub const microzig = @import("deps/microzig/build.zig");

pub const chips = @import("src/chips.zig");
pub const boards = @import("src/boards.zig");

const linkerscript_path = root() ++ "rp2040.ld";

pub const BuildOptions = struct {
    optimize: std.builtin.OptimizeMode,
};

pub const PicoExecutableOptions = struct {
    name: []const u8,
    source_file: FileSource,
    optimize: std.builtin.OptimizeMode = .Debug,
};

pub fn addPiPicoExecutable(
    builder: *Builder,
    opts: PicoExecutableOptions,
) *microzig.EmbeddedExecutable {
    return microzig.addEmbeddedExecutable(builder, .{
        .name = opts.name,
        .source_file = opts.source_file,
        .backing = .{ .board = boards.raspberry_pi_pico },
        .optimize = opts.optimize,
        .linkerscript_source_file = .{ .path = linkerscript_path },
    });
}

// this build script is mostly for testing and verification of this
// package. In an attempt to modularize -- designing for a case where a
// project requires multiple HALs, it accepts microzig as a param
pub fn build(b: *Builder) !void {
    const optimize = b.standardOptimizeOption(.{});
    var examples = Examples.init(b, optimize);
    examples.install(b);

    const pio_tests = b.addTest(.{
        .root_source_file = .{
            .path = "src/hal/pio.zig",
        },
        .optimize = optimize,
    });
    pio_tests.addIncludePath("src/hal/pio/assembler");

    const test_step = b.step("test", "run unit tests");
    test_step.dependOn(&b.addRunArtifact(pio_tests).step);
}

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".") ++ "/";
}

pub const Examples = struct {
    adc: *microzig.EmbeddedExecutable,
    blinky: *microzig.EmbeddedExecutable,
    blinky_core1: *microzig.EmbeddedExecutable,
    gpio_clk: *microzig.EmbeddedExecutable,
    pwm: *microzig.EmbeddedExecutable,
    spi_master: *microzig.EmbeddedExecutable,
    uart: *microzig.EmbeddedExecutable,
    squarewave: *microzig.EmbeddedExecutable,
    //uart_pins: microzig.EmbeddedExecutable,
    flash_program: *microzig.EmbeddedExecutable,

    pub fn init(b: *Builder, optimize: std.builtin.OptimizeMode) Examples {
        var ret: Examples = undefined;
        inline for (@typeInfo(Examples).Struct.fields) |field| {
            const path = comptime root() ++ "examples/" ++ field.name ++ ".zig";

            @field(ret, field.name) = addPiPicoExecutable(b, .{
                .name = field.name,
                .source_file = .{ .path = path },
                .optimize = optimize,
            });
        }

        return ret;
    }

    pub fn install(examples: *Examples, b: *Builder) void {
        inline for (@typeInfo(Examples).Struct.fields) |field| {
            b.installArtifact(@field(examples, field.name).inner);
        }
    }
};
