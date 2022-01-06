const std = @import("std");
const Cpu = @import("Cpu.zig");

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

const root_path = root() ++ "/";

pub const avr5 = Cpu{
    .name = "AVR5",
    .path = root_path ++ "cpus/avr/avr5.zig",
    .target = std.zig.CrossTarget{
        .cpu_arch = .avr,
        .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
        .os_tag = .freestanding,
        .abi = .eabi,
    },
};

pub const cortex_m3 = Cpu{
    .name = "ARM Cortex-M3",
    .path = root_path ++ "cpus/cortex-m3/cortex-m3.zig",
    .target = std.zig.CrossTarget{
        .cpu_arch = .arm,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
        .os_tag = .freestanding,
        .abi = .none,
    },
};
