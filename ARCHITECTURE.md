# Architecture

This document gives a high-level overview of MicroZig's codebase. If you want to contribute or understand how things fit
together, start here.

MicroZig is a Zig framework for programming microcontrollers. It provides a unified build system, hardware abstraction
layers, and device drivers across 14+ microcontroller families (ARM Cortex-M, RISC-V, AVR, MSP430). The core idea: write
portable embedded code in Zig, with platform details handled by ports and a code-generating build system.

## Codemap

```
microzig/
├── build.zig            # MicroBuild entry point (see "Build System" below)
├── build-internals/     # Target/Chip/HAL/Board type system, build-time tools
├── core/                # Foundational library: CPU, MMIO, interrupts, startup
├── port/                # Platform-specific HALs and chip definitions
├── drivers/             # HAL-agnostic device drivers
├── tools/               # Standalone CLI tools (regz, uf2, dfu, etc.)
├── modules/             # Shared libraries (libc, lwIP, FreeRTOS, RTT, etc.)
├── examples/            # Per-platform example applications
├── sim/                 # AVR simulator (aviron)
├── vendor/              # Vendored third-party code
├── website/             # Documentation site
├── design/              # Logos and design assets
└── scripts/             # Utility scripts
```

### _core/_

The foundational library that every firmware links against. Key files in `core/src/`:

- _microzig.zig_: Root API. Exposes `cpu`, `chip`, `hal`, `board`, `drivers` namespaces. Implements the default panic
  handler, `export_startup()` for entry point generation, and `std_options()` for logging integration.
- _mmio.zig_: `Mmio` generic type that wraps a packed struct into a volatile MMIO register interface with `read()`,
  `write()`, `modify()`, `toggle()` methods. Validates register sizes at comptime.
- _interrupt.zig_: `enable()`, `disable()`, critical sections, `Mutex` (HAL-provided or fallback
  `CriticalSectionMutex`), `Handler` union type.
- _allocator.zig_: Multi-tier free-list allocator.
- _cpus/_: CPU architecture implementations:
  - _cortex_m.zig_ (+ subdirectory with variants): interrupt vector tables, exception handling, FPU support, RAM
    vector tables.
  - _riscv32.zig_: RISC-V 32-bit support.
  - _avr_common.zig_, _avr25.zig_, _avr5.zig_: AVR architecture.
  - _msp430.zig_, _msp430x.zig_: TI MSP430.
- _usb.zig_: USB device stack with CDC and HID class drivers.

### _port/_

Each port implements support for a microcontroller family. This includes creating a Microzig target for various chips
(and some well-known boards) as well as implementing a HAL to support peripherals. Ports follow a consistent structure
(using `port/raspberrypi/rp2xxx/` as the reference):

```
port/<vendor>/<family>/
├── build.zig            # Chip/board/target definitions, memory regions, SVD paths
├── src/
│   ├── hal.zig          # HAL root: re-exports gpio, uart, i2c, spi, dma, etc.
│   ├── hal/             # Individual HAL modules (one file per peripheral)
│   ├── boards/          # Board configs (pin mappings, oscillator freq, LED pin)
│   └── cpus/            # CPU variants if the family has multiple cores
├── patches/             # Corrections to vendor SVD/ATDF files
└── ld/                  # Custom linker scripts (when auto-generation isn't enough)
```

The _build.zig_ in each port defines `Chip` values (SVD path, memory regions, patches) and `Board` values (root source
file with pin configs). These feed into the `Target` type from _build-internals/_.

Current ports: ESP32 (_espressif/esp_), GD32 (_gigadevice/gd32_), ATmega/ATtiny/SAMD51 (_microchip/_), nRF5x
(_nordic/nrf5x_), LPC/MCX (_nxp/_), RP2040/RP2350 (_raspberrypi/rp2xxx_), STM32 (_stmicro/stm32_), MSP430/MSPM0/TM4C
(_texasinstruments/_), CH32V (_wch/ch32v_).

### _drivers/_

Device-independent drivers that talk to hardware through base interface abstractions. Located in `drivers/src/`:

- _base/_: Interface types using a pointer+vtable pattern:
  - _Digital_IO.zig_: GPIO pin abstraction (direction, bias, read/write).
  - _I2C_Device.zig_: I2C bus communication.
  - _StreamDevice.zig_: Byte-stream I/O (UART-like).
  - _DatagramDevice.zig_: Packet-based I/O.
  - _BlockMemory.zig_: Block storage.
  - _ClockDevice.zig_: Real-time clock.
- _time/_: `Absolute` (microseconds since boot), `Duration`, `Deadline`.
- Device drivers organized by category: _display/_ (SSD1306, ST77xx, HD44780), _input/_ (debounced buttons, rotary
  encoders, keyboard matrices), _sensor/_ (temperature, motion, magnetic), _stepper/_ (A4988, DRV8825), _led/_ (WS2812),
  _wireless/_ (CYW43 WiFi/BT), _io_expander/_ (PCF8574, PCA9685).

The vtable approach lets drivers work with any HAL that implements the base interfaces. Drivers never import
port-specific code.

### _build-internals/_

The type system that ties everything together at build time. The key types in `build-internals/build.zig`:

- `Target`: A complete firmware compilation target. Bundles a `zig_target` query, `Chip`, optional
  `HardwareAbstractionLayer`, optional `Board`, `LinkerScript`, `Stack` placement, and preferred `BinaryFormat`.
  Supports `derive()` for creating variants.
- `Chip`: MCU definition: name, `register_definition` (SVD, ATDF, Zig, Embassy, or TargetDB source),
  `memory_regions`, and `patch_files`.
- `HardwareAbstractionLayer`: Root source file + imports for the HAL.
- `Board`: Root source file + imports for board-specific config.
- `MemoryRegion`: Describes a memory region (flash/RAM) with offset, length, and access permissions.
- `BinaryFormat`: Output format: `.elf`, `.binary`, `.hex`, `.uf2`, `.dfu`, `.esp`, or `.custom`.
- `LinkerScript`: Auto-generated or custom, controls section placement and rodata location (flash vs RAM).

This directory also contains the build-time tools that run during compilation: _regz/_ (register code generation),
_uf2/_, _dfu/_, _esp-image/_ (format converters), _linter/_, _sorcerer/_ (register visualizer), _printer/_,
_generate_linker_script.zig_.

### _tools/_

Standalone versions of the build-time tools, usable outside the MicroZig build system. `regz` is the most important:
it parses vendor hardware description files (SVD, ATDF, Embassy, TI TargetDB) and generates type-safe Zig MMIO register
interfaces. `sorcerer` produces SVG visualizations of register maps.

### _modules/_

Shared Zig libraries: _foundation-libc/_ (minimal libc), _freertos/_ (RTOS integration), _lwip/_ (TCP/IP stack), _rtt/_
(Segger Real-Time Transfer for debug output), _network/_ (networking abstractions), _virtual-io/_, _bounded-array/_,
_riscv32-common/_.

### _examples/_

One directory per platform, mirroring the _port/_ structure: _examples/raspberrypi/rp2xxx/_, _examples/nordic/nrf5x/_,
etc. Each has its own _build.zig_ that uses `MicroBuild` to define firmware targets. Examples often show off different
parts of the HAL.

### _sim/_

_sim/aviron/_ is an AVR instruction-level simulator for testing AVR firmware without hardware.

## Build Flow: SVD to `blink`

The path from a vendor hardware description to running firmware:

1. **Vendor provides SVD/ATDF** describing chip registers and memory layout.
2. **Port's _build.zig_** references the SVD and defines `Chip` (memory regions, patches) and `Target` values.
3. `regz` (at build time) processes the SVD (applying patches) and generates a Zig module with type-safe MMIO
   register definitions.
4. **_generate_linker_script.zig_** emits a linker script from the `Target`'s memory regions.
5. **MicroBuild's `add_firmware()`** wires everything: it creates Zig modules for `microzig` (core), `chip` (generated
   registers), `cpu`, `hal`, `board`, and `drivers`, then compiles the user's `root_source_file` against them.
6. **Startup** (_core/src/cpus/_): the CPU module provides the entry point, initializes the stack, zeroes BSS, copies
   data from flash to RAM, then calls `microzig_main` (the user's entry point).
7. **User code** calls into `hal` (e.g., `hal.gpio.init()`) which uses the generated `chip` registers to configure
   hardware. Drivers use the `hal` through base interfaces.
8. **Output conversion** transforms the ELF into the target format (UF2, HEX, DFU, etc.) for flashing.

## Build System

The build system centers on `MicroBuild`, defined in the root `build.zig`.

```zig
const MicroBuild = microzig.MicroBuild(.{ .rp2xxx = true });
const mb = MicroBuild.init(b, mz_dep) orelse return;

const fw = mb.add_firmware(.{
    .name = "blinky",
    .root_source_file = b.path("src/blinky.zig"),
    .target = mb.ports.rp2xxx.boards.raspberrypi.pico,
});
mb.install_firmware(fw, .{});
```

`add_firmware()` invokes `regz` on the chip's register definition, generates the linker script, creates all the Zig
modules, and sets up the compilation. `install_firmware()` adds the format conversion step (e.g. to _uf2_ or _bin_) and
copies the result to _zig-out/firmware/_.

## Architectural Invariants

- **Drivers never import port-specific code.** They operate exclusively through the base interfaces in
  `drivers/src/base/`. This is what makes them portable.
- **Ports never import other ports.** Each port is self-contained.
- **Core has no knowledge of specific chips.** It receives chip/HAL/board configuration through comptime module imports
  injected by the build system.
- **Register definitions are generated, not hand-written.** The source of truth is the vendor SVD/ATDF file plus
  patches. Don't edit generated register code in your local build, and don't edit the _svd_ files.
- **No global mutable state in libraries.** Embedded code uses explicit initialization and passed handles.
- **Memory regions are the port's responsibility.** Core and drivers don't assume any particular memory layout.

## Other Concerns/Conventions

**Comptime configuration**: The build system injects `microzig.config` as a comptime-known struct. User code queries it
to branch on chip features, CPU type, or board identity. HALs use it to select peripheral implementations, setup clocks,
etc.

**Startup sequence**: Each CPU architecture in _core/src/cpus/_ provides a `_start` entry point. The typical sequence
is: set stack pointer → zero BSS → copy `.data` from flash to RAM → call `microzig_main`.

**Naming conventions**: The codebase uses _snake_case_ (C-style), not the typical Zig camelCase. Run `zig fmt` for
formatting.

**MMIO access**: All register access should go through `Mmio`. The packed struct defines the register layout, the `Mmio`
wrapper prevents the compiler from optimizing away or reordering accesses. If a register is incorrect in the SVD, add a
patch. If a register is missing, you might have to use `@ptrFromInt`.
