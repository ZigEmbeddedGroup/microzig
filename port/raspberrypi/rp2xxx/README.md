# raspberrypi-rp2xxx

HAL and register definitions for the RP2040 and RP2350 chips.

## Boot sequence
### BootROM
- Source code: https://github.com/raspberrypi/pico-bootrom
- All in silicon
- Provides a bunch of optimized functions that can be leveraged by other code, for example to do a
  quick `memcpy`.

#### Process
1. Setup power regulators
2. Start power-on state machine
  1. Start ring oscillator
  2. Take certain blocks out of reset
  3. Both cores run bootrom code
3. Exit XIP, in case flash was in XIP mode from last boot
4. Copy 256 bytes from flash to RAM (stage 2 bootloader), check CRC32 on it
5. (If OK) Jump to stage2
6. Otherwise, run UF2 bl

### Stage 2
- The main job here is to configure flash for XIP so that it can execute the flashed image directly
  from flash.
- PLLs, etc. Are NOT done here. This is done by the initialization code in the flash image.

## Linker scripts
- *stage2.ld*:
  - References in `get_bootrom` in the port _build.zig_.
  - Used to build the bootloader, all its sections become irrelevant later on.
    - This linker builds the bootrom and creates an import, for the later build to `@embedFile`,
      pad and slap the CRC on.
- *rp2040.ld*:
  - Includes `.boot2` section. Which is the embedded bootloader file, embedded in _bootrom.zig_.
    - `export const bootloader_data: [256]u8 linksection(".boot2") = prepare_boot_sector(@embedFile("bootloader"));`
    - The `prepare_boot_sector` pads it up and calculates the CRC on the end.
  - `microzig_flash_start` is where the vector table is placed, at the start of flash.

## MicroZig RAM Image Support

- Can use memory from 0x20000000-0x20042000
- 0x15000000-0x15004000 is 'flash cache', which can be used as extra RAM.
> All data must be in blocks without the UF2_FLAG_NOT_MAIN_FLASH marking which relates to content to
> be ignored rather than Flash vs RAM.
  - This is a flag on each 512-byte block of the uf2.

### Overview
MicroZig supports RAM images through the `ram_image` configuration option. When enabled:
- Uses `ram_vector_table` instead of flash `_vector_table`
- Entry point is `ram_image_start()` (exported as `_entry_point`)
- `VTOR` is configured to point to the RAM vector table at runtime
- Memory initialization skips `.data` copy (since everything is already in RAM)

The rp2xxx bootrom, when flashing a UF2 file, jumps to the *lowest address flashed*, so if there are
no flash blocks (in the 0x10000000 range), then it'll just to RAM instead.

### Build Configuration
In `build.zig`, RAM images are configured with:
```zig
.ram_image = true,
.linker_script = .{ .file = b.path("ld/rp2350/arm_ram_image_sections.ld") },
.entry = .{ .symbol_name = "_entry_point" },
```

Available flashless board targets:
- `pico_flashless` (RP2040)
- `pico2_arm_flashless` (RP2350 ARM)
- `pico2_riscv_flashless` (RP2350 RISC-V)

### RAM Image Linker Scripts
RAM image linker scripts (e.g., `ld/rp2350/arm_ram_image_sections.ld`) add:

**`.bootmeta` section** (RP2350 only):
- Contains image definition block for bootrom
- Specifies image type, CPU architecture, security settings
- For ARM RAM images, includes custom entry point to override default vector table expectation

### RP2350 Boot Metadata System
RP2350 bootrom requires metadata blocks to identify and validate images. For RAM images on ARM:

**Image Definition Block** (`src/hal/bootmeta.zig`):
```zig
pub const image_def_block = if (microzig.config.ram_image and arch == .arm) Block(extern struct {
    image_def: ImageDef,
    entry_point: EntryPoint(false),
})
```

The bootmeta system:
- Creates a structured metadata block in the `.bootmeta` linker section
- Specifies image type (exe/data), CPU (arm/riscv), chip (RP2040/RP2350)
- For ARM RAM images, includes custom entry point since bootrom expects vector table at image start
- Entry point references `microzig.cpu.startup_logic.ram_image_start`
- Configurable via `microzig.options.hal.bootmeta.image_def_exe_security`

**Block structure**:
- Header: `0xffffded3`
- Items: Image definition + optional entry point
- Last item marker: `0x000000ff | (size << 8)`
- Link: Optional pointer to next block
- Footer: `0xab123579`

### Core Implementation Details

**Startup flow** (`core/src/cpus/cortex_m.zig`):

1. **Entry point** (`ram_image_start`):
   - Placed in `microzig_ram_start` linker section
   - Sets up stack pointer (MSP)
   - Jumps to `_start` function

2. **Initialization** (`_start`):
   - Calls `initialize_system_memories(.auto)`
     - for RAM images, only clears `.bss`, since `.data` is already in SRAM
   - Sets VTOR register to point to `ram_vector_table`
   - Enables fault exceptions (if SHCSR register exists)
   - Calls `microzig_main()`

3. **Vector table**:
   - `ram_vector_table` is always available when `ram_image = true`
   - Generated via `generate_vector_table()` at compile time
   - Can be modified at runtime for dynamic interrupt handler assignment
   - Aligned to 256 bytes (`VTOR` ignores lower 8 bits)

**Key differences from flash images**:
- No `.boot2` section (stage 2 bootloader not needed)
- No `.data` section copying (already in RAM)
- Entry is `_entry_point` symbol instead of vector table
- VTOR must be manually configured to point to vector table
- For RP2350 ARM, bootmeta must specify custom entry point

## RP2350 Status

The RP2350 is very similar to the RP2040, but has enough differences to require an audit of all HAL code for compatibility. The following tracks what has been verified to work on the RP2350 as compared to the RP2040:
- [ ] adc
- [x] clocks
- [ ] dma
- [ ] flash
- [x] gpio
- [ ] hw
- [ ] i2c
- [ ] irq
- [ ] multicore
- [ ] pins
- [ ] pio
- [x] pll
- [ ] pwm
- [ ] random
- [x] resets
- [ ] rom
- [ ] spi
- [x] time
- [ ] uart
- [ ] usb
- [x] watchdog
