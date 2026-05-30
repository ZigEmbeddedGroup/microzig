# dfu

Device Firmware Upgrade (DFU) for your build.zig

This package provides tools for creating DFU files from ELF binaries or raw binary files. It supports two formats:

- **Standard DFU 1.1**: simple binary with suffix and CRC (use `bin2dfu`)
- **DfuSe**: STMicroelectronics format with address information for non-contiguous memory (use `elf2dfuse`)

See https://www.usb.org/sites/default/files/DFU_1.1.pdf for the DFU specification and https://rc.fdr.hu/UM0391.pdf for DfuSe.

# Usage

## With MicroZig

When using MicroZig, DFU generation is integrated into the build system. You can request a DFU file when calling `get_emitted_bin` or `install_firmware`:

```zig
const microzig = @import("microzig");

pub fn build(b: *Build) void {
    // ...

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const firmware = mb.add_firmware(b, .{
        .name = "my_firmware",
        .target = microzig.boards.stmicro.stm32.daisy_seed,
        .optimize = optimize,
        .root_source_file = b.path("src/main.zig"),
    });

    // Install DfuSe format (default)
    firmware.install_firmware(b, .{ .format = .{ .dfu = .{} } });

    // Or with custom options:
    firmware.install_firmware(b, .{ .format = .{ .dfu = .{
        .format = .dfuse,
        .vendor_id = 0x0483,
        .product_id = 0xDF11,
    } } });

    // Standard DFU format (from ELF, uses objcopy internally)
    firmware.install_firmware(b, .{ .format = .{ .dfu = .{ .format = .standard } } });
}
```

## Standard build.zig usage

In build.zig:

```zig
const dfu = @import("dfu");

pub fn build(b: *Build) void {
    // ...
    const dfu_dep = b.dependency("dfu", .{});

    // DfuSe format (default)
    const dfu_file = dfu.from_elf(dfu_dep, elf_file, .{
        .format = .dfuse,
        .vendor_id = 0x0483,
        .product_id = 0xDF11,
    });
    _ = b.addInstallFile(dfu_file, "bin/firmware.dfu");

    // Standard DFU format (from ELF, uses objcopy internally)
    const std_dfu_file = dfu.from_elf(dfu_dep, elf_file, .{
        .format = .standard,
    });
    _ = b.addInstallFile(std_dfu_file, "bin/firmware.dfu");

    // Standard DFU format (from binary)
    const bin_dfu_file = dfu.from_bin(dfu_dep, bin_file, .{});
    _ = b.addInstallFile(bin_dfu_file, "bin/firmware.dfu");
}
```

Execute tools manually:

```zig
pub fn build(b: *Build) void {
    // ...

    const dfu_dep = b.dependency("dfu", .{});

    // elf2dfuse
    const elf2dfuse_run = b.addRunArtifact(dfu_dep.artifact("elf2dfuse"));
    elf2dfuse_run.addArgs(&.{ "--vendor-id", "0x0483" });
    elf2dfuse_run.addArgs(&.{ "--product-id", "0xDF11" });
    elf2dfuse_run.addArg("--elf-path");
    elf2dfuse_run.addArtifactArg(exe);
    elf2dfuse_run.addArg("--output-path");
    const dfu_file = elf2dfuse_run.addOutputFileArg("firmware.dfu");
    _ = b.addInstallFile(dfu_file, "bin/firmware.dfu");

    // bin2dfu
    const bin2dfu_run = b.addRunArtifact(dfu_dep.artifact("bin2dfu"));
    bin2dfu_run.addArg("--bin-path");
    bin2dfu_run.addFileArg(bin_file);
    bin2dfu_run.addArg("--output-path");
    const std_dfu_file = bin2dfu_run.addOutputFileArg("firmware.dfu");
    _ = b.addInstallFile(std_dfu_file, "bin/firmware.dfu");
}
```
