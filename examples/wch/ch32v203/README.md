## Build firmware

```bash
$ zig build -Doptimize=ReleaseSmall

$ zig build
# will make ReleaseMode and not fit to the FLASH memory.
```

## Disassemble

```bash
$ riscv64-unknown-elf-objdump --disassemble-all ELF_FILE > DISASSEMBLED_FILE
```

## Flasg firmware

- RUST: [wchisp](https://github.com/ch32-rs/wchisp)
- C: [wch-isp](https://github.com/jmaselbas/wch-isp)
  - libusb-1.0-0-dev is required to compile. Make sure not libusb-dev but libusb-1.0-0-dev.

```bash
#$ wchisp flash BIN_FILE
$ wch-isp -pr flash BIN_FILE
```
