# microzig

[![discord](https://img.shields.io/discord/824493524413710336.svg?logo=discord)](https://discord.gg/ShUWykk38X)

## NOTE: in development

APIs will likely break in the future

Table of Contents
=================

* [microzig](#microzig)
   * [Contributing](#contributing)
   * [Introduction](#introduction)
   * [How to](#how-to)
      * [Embedded project with "supported" chip/board](#embedded-project-with-supported-chipboard)
      * [Embedded project with "unsupported" chip](#embedded-project-with-unsupported-chip)
      * [Interrupts](#interrupts)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->

## Contributing

Please see the [project page](https://github.com/orgs/ZigEmbeddedGroup/projects/1/views/1), its used as a place to brainstorm and organize work in ZEG.
There will be issues marked as `good first issue`, or drafts for larger ideas that need scoping/breaking ground on.

## Introduction

This repo contains the infrastructure for getting started in an embedded Zig project, as well as some code to interact with some chips/boards. Specifically it offers:
- a single easy-to-use builder function that:
  - generates your linker script
  - sets up packages and start code
- generalized interfaces for common devices, such as UART.
- device drivers for interacting with external hardware
- an uncomplicated method to define [interrupts](#interrupts)

## How to

Here's a number of things you might be interested in doing, and how to achieve them with microzig and other ZEG tools.

### Embedded project with "supported" chip/board

Start with an empty Zig project by running `zig init-exe`, and add microzig as a git submodule (or your choice of package manager).
Then in your `build.zig`:

```zig
const std = @import("std");
const microzig = @import("path/to/microzig/src/main.zig");

pub fn build(b: *std.build.Builder) !void {
    const backing = .{
        .board = microzig.boards.arduino_nano,

        // if you don't have one of the boards, but do have one of the
        // "supported" chips:
        // .chip = microzig.chips.atmega328p,
    };

    const exe = try microzig.addEmbeddedExecutable(
        b,
        "my-executable",
        "src/main.zig",
        backing,
        .{
          // optional slice of packages that can be imported into your app:
          // .packages = &my_packages,
        },
    );
    exe.setBuildMode(.ReleaseSmall);
    exe.install();
}
```

`zig build` and now you have an executable for an Arduino Nano.
In your application you can import `microzig` in order to interact with the hardware:

```zig
const microzig = @import("microzig");

// `microzig.chip.registers`: access to register definitions

pub fn main() !void {
    // your program here
}
```

### Embedded project with "unsupported" chip

If you have a board/chip that isn't defined in microzig, you can set it up yourself!
You need to have:
- SVD or ATDF file defining registers
- flash and ram address and sizes

First use [regz](https://github.com/ZigEmbeddedGroup/regz) to generate the register definitions for your chip and save them to a file.
Then your `build.zig` is going to be the same, but you'll define the chip yourself:

```zig
const nrf52832 = Chip{
    .name = "nRF52832",
    .path = "path/to/generated/file.zig",
    .cpu = cpus.cortex_m4,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x00000000, .length = 0x80000, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
    },
};

const backing = .{
    .chip = nrf52832,
};
```

NOTE: `regz` is also still in development, and while it tends to generate code well, it's possible that there will be errors in the generated code!
Please create an issue if you run into anything fishy.

### Interrupts

The current supported architectures for interrupt vector generation are ARM and AVR.
To define the Interrupt Service Routine (ISR) for a given interrupt, you create a function with the same name in an `interrupts` namespace:

```zig

pub const interrupts = struct {
    pub fn PCINT0() void {
      // interrupt handling code
    }
};

pub fn main() !void {
    // my application
}
```

We're using compile-time checks along with the generated code to determine the list of interrupts.
If a function is defined whose name is not in this list, you'll get a compiler error with the list of interrupts/valid names.
