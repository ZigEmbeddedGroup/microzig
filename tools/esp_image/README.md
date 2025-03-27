# esp image

Esp image creator for your build.zig.

## Example
```zig
const esp_image = @import("esp_image");

pub fn build(b: *Build) void {
    // ...

    const esp_image_dep = b.dependency("esp_image", .{});
    const image_file = esp_image.from_elf(esp_image_dep, elf_file, .{
        .chip_id = .esp32_c3,
    });

    b.addInstallFile(image_file, "test.bin");
}
```
