# Sorcerer

Sorcerer is a suite of tools for visualizing and generating MicroZig register definitions. It
consists of two components:

- **Sorcerer (GUI)**: A graphical application for browsing and editing register definitions
- **sorcerer-cli**: A command-line tool for generating register code

Both tools work with MicroZig's register definition files (SVD, ATDF, Embassy formats) and use
[regz](../regz/) to generate type-safe Zig code.

## Building

From the `tools/sorcerer/` directory:

```bash
# Build both tools
zig build
```

## Sorcerer GUI

The GUI provides an interactive interface for:
- Browsing all MicroZig register definitions
- Viewing generated Zig code with syntax highlighting
- Opening custom SVD/ATDF files
- Searching chips, boards, and targets
- Viewing patch files that modify register definitions
- Statistics overview showing chip counts, formats, and patch coverage

### Running

```bash
zig build run
# or
./zig-out/bin/sorcerer
```

### Dependencies

The GUI requires additional dependencies:
- DVUI (SDL3-based UI framework)
- tree-sitter-zig (syntax highlighting)
- serial (serial port communication)

## `sorcerer-cli`

A lightweight CLI alternative that generates register definitions without GUI dependencies.

### Usage

```
sorcerer-cli <command> [options]

Commands:
  list                    List all available targets
  generate <chip>         Generate register definitions for a chip

Options for 'list':
  --port <name>           Filter by port name (e.g., rp2xxx, ch32v)
  --json                  Output in JSON format

Options for 'generate':
  -o, --output <dir>      Output directory (default: ./zig-out)

General options:
  -h, --help              Show help
```

### Examples

```bash
# List all available chips
./zig-out/bin/sorcerer-cli list

# Output:
# CHIP                     PORT                     BOARD
# ------------------------ ------------------------ --------------------------------
# RP2040                   raspberrypi/rp2xxx       Raspberry Pi Pico
# RP2350                   raspberrypi/rp2xxx       Raspberry Pi Pico 2
# STM32F103C8              stmicro/stm32            -
# CH32V003                 wch/ch32v                -
# ...

# Filter by port (substring matching)
./zig-out/bin/sorcerer-cli list --port rp2xxx

# JSON output (for scripting)
./zig-out/bin/sorcerer-cli list --json | jq '.[] | select(.port | contains("rp2xxx"))'

# Generate register definitions for a chip
./zig-out/bin/sorcerer-cli generate RP2040 -o ./my-regs/

# This generates:
# ./my-regs/RP2040.zig
# ./my-regs/types.zig
# ./my-regs/types/
```

### Running via build system

```bash
# Run CLI with arguments
zig build run-cli -- list --port ch32v
zig build run-cli -- generate CH32V003 -o /tmp/regs
```

## Architecture

Both tools share the same underlying data:

1. **Build time**: `build.zig` collects all register definitions from MicroZig ports
2. **Schema generation**: Schemas are embedded as Zig compile-time constants in a generated
   `register_schemas.zig` file
3. **Both GUI and CLI**: Import the same `schemas` module - no runtime file loading or JSON parsing
   needed

## Register Definition Formats

Sorcerer supports the following formats via regz:

| Format | Extension | Description |
|--------|-----------|-------------|
| SVD | `.svd` | ARM CMSIS System View Description |
| ATDF | `.atdf` | Microchip ATDF (AVR/SAM devices) |
| Embassy | - | Embassy HAL register definitions |
| TargetDB | - | TI TargetDB format |
