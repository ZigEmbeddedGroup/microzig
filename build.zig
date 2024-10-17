const builtin = @import("builtin");
const std = @import("std");
const Build = std.Build;

const internals = @import("microzig/build-internals");

const MicroZig = @This();

b: *Build,
dep: *Build.Dependency,

pub fn build(_: *Build) void {}

pub fn init(b: *Build, dep: *Build.Dependency) *MicroZig {
    const mz = b.allocator.create(MicroZig) catch @panic("out of memory");
    mz.* = .{
        .b = b,
        .dep = dep,
    };

    return mz;
}

pub const PortSelect = struct {
    rp2xxx: bool = false,
};

pub inline fn load_ports(mz: *MicroZig, comptime port_select: PortSelect) type {
    // This should ensure that lazyImport never fails. Kind of a hacky way to do things, but it should work
    var should_quit = false;
    should_quit = should_quit or
        if (port_select.rp2xxx) mz.dep.builder.lazyDependency("microzig/port/raspberrypi/rp2xxx", .{}) == null else false;
    if (should_quit) {
        std.process.exit(0);
    }

    const rp2xxx_port = if (port_select.rp2xxx)
        mz.dep.builder.lazyImport(@This(), "microzig/port/raspberrypi/rp2xxx").?
    else
        @compileError("Please provide `.rp2xxx = true` to enable the port.");

    return struct {
        pub const rp2xxx = rp2xxx_port;
    };
}

pub fn get_target(_: *MicroZig, alias: *const internals.TargetAlias) internals.Target {
    return internals.get_target(alias) orelse @panic("target not found");
}

pub const CreateFirmwareOptions = struct {
    name: []const u8,
    target: internals.Target,
    optimize: std.builtin.OptimizeMode,
    root_source_file: Build.LazyPath,
    imports: []const Build.Module.Import = &.{},
};

pub fn add_firmware(mz: *MicroZig, options: CreateFirmwareOptions) *Build.Step.Compile {
    const target = options.target;
    const zig_target = mz.dep.builder.resolveTargetQuery(target.cpu);
    const cpu = Cpu.init(zig_target.result);

    const config = mz.dep.builder.addOptions();
    config.addOption(bool, "has_hal", target.hal != null);
    config.addOption(bool, "has_board", target.board != null);

    config.addOption([]const u8, "cpu_name", zig_target.result.cpu.model.name);
    config.addOption([]const u8, "chip_name", target.chip.name);

    // NOTE: should you pass optimize? the same for all
    const core_mod = mz.dep.builder.createModule(.{
        .root_source_file = mz.dep.path("core/microzig.zig"),
        .imports = &.{
            .{
                .name = "config",
                .module = config.createModule(),
            },
        },
    });

    const cpu_mod = cpu.create_module(mz.dep.builder);
    cpu_mod.addImport("microzig", core_mod);
    core_mod.addImport("cpu", cpu_mod);

    const chip_mod = target.chip.module.create_module();
    chip_mod.addImport("microzig", core_mod);
    core_mod.addImport("chip", chip_mod);

    if (target.hal) |hal| {
        const hal_mod = hal.create_module();
        hal_mod.addImport("microzig", core_mod);
        core_mod.addImport("hal", hal_mod);
    }

    if (target.board) |board| {
        const board_mod = board.create_module();
        board_mod.addImport("microzig", core_mod);
        core_mod.addImport("board", board_mod);
    }

    const app_mod = mz.b.createModule(.{
        .root_source_file = options.root_source_file,
        .imports = options.imports,
    });
    app_mod.addImport("microzig", core_mod);

    const artifact = mz.b.addExecutable(.{
        .name = options.name,
        .target = zig_target,
        .optimize = options.optimize,
        .root_source_file = mz.dep.path("core/start.zig"),
    });

    artifact.root_module.addImport("microzig", core_mod);
    artifact.root_module.addImport("app", app_mod);

    // If not specified then generate the linker script
    artifact.setLinkerScript(target.linker_script);

    return artifact;
}

pub fn install_firmware(mz: *MicroZig, artifact: *Build.Step.Compile) void {
    mz.b.installArtifact(artifact);
}

const Cpu = enum {
    avr5,
    cortex_m,
    riscv32,

    pub fn init(target: std.Target) Cpu {
        if (target.cpu.arch.isThumb()) {
            return .cortex_m;
        }

        @panic("unrecognized cpu configuration");
    }

    pub fn create_module(cpu: Cpu, b: *Build) *Build.Module {
        return b.createModule(.{
            .root_source_file = switch (cpu) {
                .avr5 => b.path("cpus/avr5.zig"),
                .cortex_m => b.path("cpus/cortex_m.zig"),
                .riscv32 => b.path("cpus/riscv32.zig"),
            },
        });
    }
};

// fn init_cpu_map(mz: *MicroZig) void {
//     mz.cpu_map.put(.avr5, .{
//         .name = "avr5",
//         .root_source_file = mz.dep.path("cpus/avr5.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .avr,
//             .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m0, .{
//         .name = "cortex_m0",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m0plus, .{
//         .name = "cortex_m0plus",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m3, .{
//         .name = "cortex_m3",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m33, .{
//         .name = "cortex_m33",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m4, .{
//         .name = "cortex_m4",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m4f, .{
//         .name = "cortex_m4f",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.zig.CrossTarget{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
//             .cpu_features_add = std.Target.arm.featureSet(&.{.vfp4d16sp}),
//             .os_tag = .freestanding,
//             .abi = .eabihf,
//         },
//     });
//     mz.cpu_map.put(.cortex_m7, .{
//         .name = "cortex_m7",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.zig.CrossTarget{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m7 },
//             .os_tag = .freestanding,
//             .abi = .eabihf,
//         },
//     });
//     mz.cpu_map.put(.riscv32_imac, .{
//         .name = "riscv32_imac",
//         .root_source_file = mz.dep.path("cpus/riscv32.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .riscv32,
//             .cpu_model = .{ .explicit = &std.Target.riscv.cpu.sifive_e21 },
//             .os_tag = .freestanding,
//             .abi = .none,
//         },
//     });
// }
