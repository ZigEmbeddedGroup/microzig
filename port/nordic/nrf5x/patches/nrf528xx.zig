const Patch = @import("microzig/build-internals").Patch;

pub const patches: []const Patch = &.{
    .{
        .add_enum = .{
            .parent = "types.peripherals.P0",
            .@"enum" = .{
                .name = "Pull",
                .bitsize = 2,
                .fields = &.{
                    .{ .value = 0x0, .name = "disabled" },
                    .{ .value = 0x1, .name = "down" },
                    .{ .value = 0x2, .name = "up" },
                },
            },
        },
    },
    .{ .set_enum_type = .{ .of = "types.peripherals.P0.PIN_CNF.PULL", .to = "types.peripherals.P0.Pull" } },
    .{
        .add_enum = .{
            .parent = "types.peripherals.P0",
            .@"enum" = .{
                .name = "DriveStrength",
                .bitsize = 3,
                .fields = &.{
                    .{ .value = 0x0, .name = "SOS1" },
                    .{ .value = 0x1, .name = "HOS1" },
                    .{ .value = 0x2, .name = "SOH1" },
                    .{ .value = 0x3, .name = "HOH1" },
                    .{ .value = 0x4, .name = "DOS1" },
                    .{ .value = 0x5, .name = "DOH1" },
                    .{ .value = 0x6, .name = "SOD1" },
                    .{ .value = 0x7, .name = "HOD1" },
                },
            },
        },
    },
    .{ .set_enum_type = .{ .of = "types.peripherals.P0.PIN_CNF.DRIVE", .to = "types.peripherals.P0.DriveStrength" } },
};
