const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;

/// MicroZig target definition.
pub const Target = struct {
    cpu: CpuKind,

    linker_script: LazyPath,

    chip: *Module,

    hal: ?*Module = null,

    board: ?*Module = null,
};

/// Cpu variants supported by MicroZig.
// TODO: riscv extensions support (solution: maybe make this a tagged union?)
pub const CpuKind = enum {
    avr5,
    cortex_m0,
    cortex_m0plus,
    cortex_m3,
    cortex_m33,
    cortex_m4,
    cortex_m4f,
    cortex_m7,
    riscv32_imac,
};

pub const ChipRegisters = union(enum) {
    /// Use `regz` to create a zig file from a JSON schema.
    json: LazyPath,

    /// Use `regz` to create a json file from a SVD schema.
    svd: LazyPath,

    /// Use `regz` to create a zig file from an ATDF schema.
    atdf: LazyPath,

    /// Use the provided file directly as the chip file.
    zig: LazyPath,

    pub fn create_module(regs: ChipRegisters, b: *Build, regz_exe: *Build.Step.Compile) *Module {
        const chip_source = switch (regs) {
            .json, .atdf, .svd => |file| blk: {
                const regz_run = b.addRunArtifact(regz_exe);

                regz_run.addArg("--schema"); // Explicitly set schema type, one of: svd, atdf, json
                regz_run.addArg(@tagName(target.chip.register_definition));

                regz_run.addArg("--output_path"); // Write to a file
                const zig_file = regz_run.addOutputFileArg("chip.zig");

                regz_run.addFileArg(file);

                break :blk zig_file;
            },

            .zig => |src| src,
        };
    }
};
