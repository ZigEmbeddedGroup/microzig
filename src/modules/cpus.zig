const std = @import("std");

pub const Cpu = struct {
    name: []const u8,
    path: []const u8,
    target: std.zig.CrossTarget,
};

pub const avr5 = Cpu{
    .name = "AVR5",
    .path = "src/modules/cpus/avr/avr5.zig",
    .target = std.zig.CrossTarget{
        .cpu_arch = .avr,
        .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
        .os_tag = .freestanding,
        .abi = .eabi,
    },
};

pub const cortex_m3 = Cpu{
    .name = "ARM Cortex-M3",
    .path = "src/modules/cpus/cortex-m3/cortex-m3.zig",
    .target = std.zig.CrossTarget{
        .cpu_arch = .arm,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
        .os_tag = .freestanding,
        .abi = .none,
    },
};
