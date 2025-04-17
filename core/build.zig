const std = @import("std");

pub fn build(b: *std.Build) !void {
    b.addNamedLazyPath("cpu_cortex_m", b.path("src/cpus/cortex_m.zig"));
    b.addNamedLazyPath("cpu_riscv32", b.path("src/cpus/riscv32.zig"));
    b.addNamedLazyPath("cpu_avr5", b.path("src/cpus/avr5.zig"));

    const unit_tests = b.addTest(.{
        // We're not using the `start.zig` entrypoint as it overrides too much
        // configuration
        .root_source_file = b.path("src/microzig.zig"),
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    b.getInstallStep().dependOn(&run_unit_tests.step);
}
