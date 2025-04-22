const std = @import("std");

pub fn build(b: *std.Build) void {
    _ = b.addModule("riscv32-common", .{
        .root_source_file = b.path("src/riscv32.zig"),
    });
}
