const std = @import("std");

const pkgs = struct {
    const koino = std.build.Pkg{
        .name = "koino",
        .source = .{ .path = "./deps/koino/src/koino.zig" },
        .dependencies = &[_]std.build.Pkg{
            std.build.Pkg{ .name = "libpcre", .source = .{ .path = "deps/koino/vendor/libpcre/src/main.zig" } },
            std.build.Pkg{ .name = "htmlentities", .source = .{ .path = "deps/koino/vendor/htmlentities/src/main.zig" } },
            std.build.Pkg{ .name = "clap", .source = .{ .path = "deps/koino/vendor/zig-clap/clap.zig" } },
            std.build.Pkg{ .name = "zunicode", .source = .{ .path = "deps/koino/vendor/zunicode/src/zunicode.zig" } },
        },
    };
};

const linkPcre = @import("deps/koino/vendor/libpcre/build.zig").linkPcre;

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const render_website = b.addExecutable("zeg-website", "src/main.zig");
    render_website.setTarget(target);
    render_website.setBuildMode(mode);
    try linkPcre(render_website);
    render_website.addPackage(pkgs.koino);
    render_website.install();

    const gen_cmd = render_website.run();

    const gen_step = b.step("gen", "Generates the website");
    gen_step.dependOn(&gen_cmd.step);
}
