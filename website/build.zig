const std = @import("std");
const zine = @import("zine");

pub fn build(b: *std.Build) !void {
    // Override the version Zine reports about itself so it matches
    // `.zine_version` in zine.ziggy, bypassing the version check.
    // Zine's build.zig exposes a `-Dversion` option for exactly this.
    const zine_dep = b.dependencyFromBuildZig(zine, .{
        .optimize = .ReleaseFast,
        .@"no-git-version" = true,
        .version = "0.12.0",
    });

    // Release build (replaces zine.website)
    const run_release = b.addRunArtifact(zine_dep.artifact("zine"));
    run_release.setCwd(b.path("."));
    run_release.addArg("release");
    run_release.addPrefixedFileArg("--output=", b.graph.path(.install_prefix, ""));
    b.getInstallStep().dependOn(&run_release.step);

    // Dev server (replaces zine.serve)
    const serve = b.step("serve", "Start the Zine dev server");
    const run_serve = b.addRunArtifact(zine_dep.artifact("zine"));
    run_serve.setCwd(b.path("."));
    serve.dependOn(&run_serve.step);
}
