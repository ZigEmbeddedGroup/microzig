# uf2

USB Flashing Format (UF2) for your build.zig

This package is for assembling uf2 files from ELF binaries. This format is used for flashing a microcontroller over a mass storage interface, such as the Pi Pico.

See https://github.com/microsoft/uf2#file-containers for how we're going to embed file source into the format.

# Usage

As a library: checkout [example.zig](src/example.zig).

elf2uf2 in build.zig:

```zig
const uf2 = @import("uf2");

pub fn build(b: *Build) void {
    // ...
    const uf2_dep = b.dependency("uf2", .{});

    const uf2_file = uf2.from_elf(uf2_dep, exe, .{ .family_id = .RP2040 });
    _ = b.addInstallFile(uf2_file, "bin/test.uf2");
}

```

Execute elf2uf2 manually:

```zig
pub fn build(b: *Build) void {
    // ...

    const uf2_dep = b.dependency("uf2", .{});

    const elf2uf2_run = b.addRunArtifact(uf2_dep.artifact("elf2uf2"));

    // family id
    elf2uf2_run.addArgs(&.{"--family-id", "RP2040"});

    // elf file
    elf2uf2_run.addArg("--elf-path");
    elf2uf2_run.addArtifactArg(exe);

    // output file
    const uf2_file = elf2uf2_run.addPrefixedOutputFileArg("--output-path", "test.uf2");
    _ = b.addInstallFile(uf2_file, "bin/test.uf2");
}
```
