# microzig-driver-framework

A collection of device drivers for the use with MicroZig.

> THIS PROJECT IS NOT READY YET!  
> We are still working out some things.

## Installation

Import this package in your build.zig and add the `drivers` package to your firmware:

### With package manager

```zig
const mdf_dep = b.dependency("microzig-driver-framework", .{});

const exe = microzig.addEmbeddedExecutable(builder, .{ … });
exe.addAppDependency("drivers", mdf_dep.module("drivers"), .{ .depend_on_microzig = true });
```

### With source code vendoring/submodules

```zig
const mdf_dep = b.anonymousDependency(
    "vendor/microzig-driver-framework",
    @import("vendor/microzig-driver-framework/build.zig"),
    .{},
);

const exe = microzig.addEmbeddedExecutable(builder, .{ … });
exe.addAppDependency("drivers", mdf_dep.module("drivers"), .{ .depend_on_microzig = true });
```

## Drivers

> Drivers with a checkmark are already implemented, drivers without are missing

- Input
  - [x] Keyboard Matrix
  - [ ] Rotary Encoder
  - Touch
    - [ ] XPT2046
- Display
  - [x] SSD1306
  - [ ] ILI9488
  - [ ] ST7735
- Wireless
  - [ ] SX1278
