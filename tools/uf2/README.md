# uf2

USB Flashing Format (UF2) for your build.zig

This package is for assembling uf2 files from ELF binaries. This format is used for flashing a microcontroller over a mass storage interface, such as the Pi Pico.

See https://github.com/microsoft/uf2#file-containers for how we're going to embed file source into the format.

For use in a build.zig:

```zig
const uf2 = @import("uf2");

pub fn build(b: *Build) void {
    // ...

    const uf2_file = uf2.from_elf(b, exe, .{ .family_id = .RP2040 });
    b.installFile(uf2_file_source);

    // ...
}
```
