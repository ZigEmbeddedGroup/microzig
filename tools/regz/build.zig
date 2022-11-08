const std = @import("std");
const deps = @import("deps.zig");

const pkgs = deps.pkgs;
const libxml2 = deps.build_pkgs.libxml2;
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const Step = std.build.Step;
const GeneratedFile = std.build.GeneratedFile;

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse unreachable) ++ "/";
}

pub const Regz = struct {
    builder: *Builder,
    exe: *LibExeObjStep,
    build_options: *std.build.OptionsStep,
    xml: libxml2.Library,

    pub const Options = struct {
        target: ?std.zig.CrossTarget = null,
        mode: ?std.builtin.Mode = null,
    };

    pub fn create(builder: *Builder, opts: Options) *Regz {
        const target = opts.target orelse std.zig.CrossTarget{};
        const mode = opts.mode orelse .Debug;

        const xml = libxml2.create(builder, target, mode, .{
            .iconv = false,
            .lzma = false,
            .zlib = false,
        }) catch unreachable;
        xml.step.install();

        const commit_result = std.ChildProcess.exec(.{
            .allocator = builder.allocator,
            .argv = &.{ "git", "rev-parse", "HEAD" },
            .cwd = comptime root(),
        }) catch unreachable;

        const build_options = builder.addOptions();
        build_options.addOption([]const u8, "commit", commit_result.stdout);

        const exe = builder.addExecutable("regz", comptime root() ++ "src/main.zig");
        exe.setTarget(target);
        exe.setBuildMode(mode);
        exe.addOptions("build_options", build_options);
        exe.addPackagePath("clap", comptime root() ++ pkgs.clap.source.path);
        xml.link(exe);

        var regz = builder.allocator.create(Regz) catch unreachable;
        regz.* = Regz{
            .builder = builder,
            .exe = exe,
            .build_options = build_options,
            .xml = xml,
        };

        return regz;
    }

    pub fn addGeneratedChipFile(regz: *Regz, schema_path: []const u8) GeneratedFile {
        // generate path where the schema will go
        // TODO: improve collision resistance
        const basename = std.fs.path.basename(schema_path);
        const extension = std.fs.path.extension(basename);
        const destination_path = std.fs.path.join(regz.builder.allocator, &.{
            regz.builder.cache_root,
            "regz",
            std.mem.join(regz.builder.allocator, "", &.{
                basename[0 .. basename.len - extension.len],
                ".zig",
            }) catch unreachable,
        }) catch unreachable;

        const run_step = regz.exe.run();
        run_step.addArgs(&.{
            schema_path,
            "-o",
            destination_path,
        });

        return GeneratedFile{
            .step = &run_step.step,
            .path = destination_path,
        };
    }
};

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const regz = Regz.create(b, .{
        .target = target,
        .mode = mode,
    });
    regz.exe.install();

    const run_cmd = regz.exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const ndjson = b.addExecutable("ndjson", "src/ndjson.zig");
    ndjson.addPackagePath("xml", "src/xml.zig");
    regz.xml.link(ndjson);

    const ndjson_run = ndjson.run();
    ndjson_run.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        ndjson_run.addArgs(args);
    }

    const ndjson_step = b.step("ndjson", "Run ndjson program");
    ndjson_step.dependOn(&ndjson_run.step);

    const test_chip_file = regz.addGeneratedChipFile("tests/svd/cmsis-example.svd");

    const tests = b.addTest("tests/main.zig");
    tests.setTarget(target);
    tests.setBuildMode(mode);
    tests.addOptions("build_options", regz.build_options);
    tests.addPackagePath("xml", "src/xml.zig");
    tests.addPackagePath("Database", "src/Database.zig");
    regz.xml.link(tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&tests.step);
    test_step.dependOn(test_chip_file.step);
}
