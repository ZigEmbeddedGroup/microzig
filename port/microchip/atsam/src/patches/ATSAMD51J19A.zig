const Patch = @import("microzig/build-internals").Patch;

pub const patches: []const Patch = &.{
    .{ .set_device_property = .{
        .device_name = "ATSAMD51J19A",
        .key = "cpu.fpuPresent",
        .value = "true",
    } },
};
