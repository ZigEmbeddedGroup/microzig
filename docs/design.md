G MicroZig Design

## Dependency Tree

The build portion of MicroZig sets up a dependency graph like the following.

![](images/deps.svg)

Your application lives in `app`; that's where `main()` resides. `root` contains
the entry point and will set up [zero-initialized data] and [uninitialized
data]. This is all encapsulated in an `EmbeddedExecutable` object. It has
methods to add dependencies acquired from the package manager.

The `microzig` module has different namespaces, some are static, but the nodes
you see in the diagram above are switched out according to your configured
hardware.

## Configurable Modules under `microzig`

The configurable modules, with the exception of `config`, are able to import
`microzig`. This exists so that one module may access another through
`microzig`. This allows us to have patterns like the `hal` grabbing the
frequency of an external crystal oscillator from `board`. Information stays
where it's relevant. Circular dependencies of declarations will result in a
compile error.

### `cpu`

This module models your specific CPU and is important for initializing memory.
Generally, you shouldn't need to define this yourself, it's likely that MicroZig
will have the definition for you.

Further research is needed for SOCs with multiple, heterogeneous CPUs. Likely it
means patching together multiple `EmbeddedExecutable`s.

### `chip`

This module is intended for generated code from
(Regz)[https://github.com/ZigEmbeddedGroup/microzig/tree/main/tools/regz]. You
can hand write this code if you like, but needs to be structured as follows:

```zig
pub const types = struct {
    // type definitions for peripherals here
};

pub const devices = struct {
    pub const chip_name = struct {
        // peripherals and interrupt table here ...
    };
};
```

This code generation has a `devices` namespace where your specific hardware will
reside. When defining a `Chip`, which is ultimately used in the creation of an
`EmbeddedExecutable`, the name must exactly match the name under the `devices`
namespace. It's okay if the name has white space, for that we can use `@""`
notation.

Let's say we had a device with the name `STM32F103`. We'd define our target as:

```zig
pub const stm32f103: microzig.Target = .{
    .dep = dep,
    .preferred_binary_format = .elf,
    .zig_target = .{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
        .os_tag = .freestanding,
        .abi = .eabi,
    },
    .chip = .{
        .name = "STM32F103RD",
        .register_definition = .{
            .zig = b.path("/path/to/file.zig"),
        },
        .memory_regions = &.{
            .{ .tag = .flash, .offset = 0x08000000, .length = 64 * 1024, .access = .rx },
            .{ .tag = .ram, .offset = 0x20000000, .length = 20 * 1024, .access = .rwx },
        },
    },
    .hal = .{
        .root_source_file = b.path("/path/to/file.zig"),
    },
};
```

As discussed, the `target.chip.name` must match a namespace under `devices` in the `chip` source.

### `hal`

This module contains hand-written code for interacting with the chip.

TODO

### `board`

TODO

### `config`

TODO

## Static Namespaces under `microzig`

TODO

## Linker Script Generation

Every firmware needs a linker script that places stuff where it belongs in
memory. When porting microzig to a new target you must face the challenge of
dealing with a linker script. But fear not as microzig has your back (in most
cases). Let's checkout the `linker_script` field in `Target`.

```zig
linker_script: LinkerScript = .{},
```

```zig
pub const LinkerScript = struct {
    /// Will anything be auto-generated for this linker script?
    generate: GenerateOptions = .{ .memory_regions_and_sections = .{} },
    /// Linker script path. Will be appended after what is auto-generated if it's not null.
    file: ?LazyPath = null,

    pub const GenerateOptions = union(enum) {
        /// Only generates a comment with target info.
        none,
        /// Only generates memory regions.
        memory_regions,
        /// Generates memory regions and default sections based on the provided options.
        memory_regions_and_sections: struct {
            /// Where should rodata go?
            rodata_location: enum {
                /// Place rodata in the first region tagged as flash.
                flash,
                /// Place rodata in the first region tagged as ram.
                ram,
            } = .flash,
        },
    };
};
```

For an example of how it is used let's look at rp2040. In this case, we need a
more complex linker script as the firmware must start with the bootrom.
Fortunately, we can still mostly auto-generate one and just patch it up a bit.

```zig
// port/raspberrypi/rp2xxx/build.zig

...
    const chip_rp2040: microzig.Target = .{
        ...
        .chip = .{
            ...
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x10000000, .length = 2048 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 256 * 1024, .access = .rwx },
            },
            ...
        },
        .linker_script = .{
            .file = b.path("ld/rp2040/sections.ld"),
        },
    };
...
```

```ld
/* port/raspberrypi/rp2xxx/ld/rp2040/sections.ld */

SECTIONS
{
  .boot2 : {
    __boot2_start__ = .;
    KEEP (*(.boot2))
    __boot2_end__ = .;
  } > flash0

  ASSERT(__boot2_end__ - __boot2_start__ == 256,
    "ERROR: Pico second stage bootloader must be 256 bytes in size")
}
INSERT BEFORE .flash_start;
```

This is the generated linker script:

```ld
/*
 * Target CPU:  cortex_m0plus
 * Target Chip: RP2040
 */

/*
 * This section was auto-generated by microzig.
 */
MEMORY
{
  flash0 (rx!w) : ORIGIN = 0x10000000, LENGTH = 0x00200000
  ram0 (rwx) : ORIGIN = 0x20000000, LENGTH = 0x00040000
}
SECTIONS
{
  .flash_start :
  {
    KEEP(*(microzig_flash_start))
  } > flash0

  .text :
  {
    *(.text*)
    *(.srodata*)
    *(.rodata*)
  } > flash0

  .ARM.extab : {
    *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > flash0

  .ARM.exidx : {
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
  } > flash0

  .data :
  {
    microzig_data_start = .;
    *(.sdata*)
    *(.data*)
    KEEP(*(.ram_text))
    microzig_data_end = .;
  } > ram0 AT> flash0

  .bss (NOLOAD) :
  {
    microzig_bss_start = .;
    *(.sbss*)
    *(.bss*)
    microzig_bss_end = .;
  } > ram0

  .flash_end :
  {
    microzig_flash_end = .;
  } > flash0

  microzig_data_load_start = LOADADDR(.data);
}
/*
 * End of auto-generated section.
 */
SECTIONS
{
  .boot2 : {
    __boot2_start__ = .;
    KEEP (*(.boot2))
    __boot2_end__ = .;
  } > flash0

  ASSERT(__boot2_end__ - __boot2_start__ == 256,
    "ERROR: Pico second stage bootloader must be 256 bytes in size")
}
INSERT BEFORE .flash_start;
```

### Things to know
- If the ram memory region used by the linker script generator (the first one)
is executable, a `.ram_text` section will be included for code that should
be placed in ram. For instance, this applies to the rp2040 port where the
section tagged as ram is executable.

## JSON register schema

TODO

## Interrupts

TODO
