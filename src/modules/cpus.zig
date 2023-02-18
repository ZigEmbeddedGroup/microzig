const std = @import("std");
const Cpu = @import("Cpu.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub const avr5 = Cpu{
    .name = "AVR5",
    .source = .{
        .path = std.fmt.comptimePrint("{s}/cpus/avr5.zig", .{root_dir()}),
    },
    .target = std.zig.CrossTarget{
        .cpu_arch = .avr,
        .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
        .os_tag = .freestanding,
        .abi = .eabi,
    },
};

pub const cortex_m0 = Cpu{
    .name = "ARM Cortex-M0",
    .source = .{
        .path = std.fmt.comptimePrint("{s}/cpus/cortex-m.zig", .{root_dir()}),
    },
    .target = std.zig.CrossTarget{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
        .os_tag = .freestanding,
        .abi = .none,
    },
};

pub const cortex_m0plus = Cpu{
    .name = "ARM Cortex-M0+",
    .source = .{
        .path = std.fmt.comptimePrint("{s}/cpus/cortex-m.zig", .{root_dir()}),
    },
    .target = std.zig.CrossTarget{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
        .os_tag = .freestanding,
        .abi = .none,
    },
};

pub const cortex_m3 = Cpu{
    .name = "ARM Cortex-M3",
    .source = .{
        .path = std.fmt.comptimePrint("{s}/cpus/cortex-m.zig", .{root_dir()}),
    },
    .target = std.zig.CrossTarget{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
        .os_tag = .freestanding,
        .abi = .none,
    },
};

pub const cortex_m4 = Cpu{
    .name = "ARM Cortex-M4",
    .source = .{
        .path = std.fmt.comptimePrint("{s}/cpus/cortex-m.zig", .{root_dir()}),
    },
    .target = std.zig.CrossTarget{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
        .os_tag = .freestanding,
        .abi = .none,
    },
};

pub const riscv32_imac = Cpu{
    .name = "RISC-V 32-bit",
    .source = .{
        .path = std.fmt.comptimePrint("{s}/cpus/riscv32.zig", .{root_dir()}),
    },
    .target = std.zig.CrossTarget{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.sifive_e21 },
        .os_tag = .freestanding,
        .abi = .none,
    },
};
