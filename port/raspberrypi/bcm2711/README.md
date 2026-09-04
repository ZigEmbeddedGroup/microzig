# raspberrypi-bcm2711

Bare metal support for the Broadcom BCM2711, the SoC of the Raspberry Pi 4 Model B.

This is an application processor rather than a microcontroller, so the port looks different from
the rest of microzig. It is a bring up port: it boots, drives gpio, talks over the serial console
and keeps time. There is no mmu, no cache, no interrupt controller and no multicore support.

## Boot sequence

There is no flash to execute from and no reset vector table to place. The VideoCore, not the ARM
cores, starts first:

1. The VideoCore boots off the SD card, reads `config.txt` and brings up the sdram and the clocks.
2. It loads `kernel8.img` from the boot partition to physical address `0x80000`.
3. It runs `armstub8.bin`, which drops to EL2, parks cores 1 to 3 on a spin table and enters the
   image at its first byte on core 0.

So a firmware here is a plain ram image whose first byte is the entry point, which is what
`ld/kernel8_sections.ld` lays out and what `.ram_image = true` in the port tells microzig.

`src/cpus/cortex_a72.zig` then parks anything that is not core 0 (so the image survives being
entered by all four), points the stack at the top of the ram region, clears `.bss` and installs an
exception vector table before calling `main`.

The port stays at the exception level it was handed, EL2, rather than dropping to EL1. Everything
it touches is reachable from there and it keeps the bring up small.

## Getting a firmware onto a board

Take a card with Raspberry Pi OS on it, or any card whose boot partition holds the firmware files
(`start4.elf`, `fixup4.dat`, `bcm2711-rpi-4-b.dtb`), and replace the kernel:

```sh
cp zig-out/firmware/blinky.bin /Volumes/bootfs/kernel8.img
```

`config.txt` needs at least:

```
arm_64bit=1
kernel=kernel8.img
```

## Peripherals

Broadcom publishes no SVD for this part, so `src/chips/BCM2711.zig` writes the registers this port
uses out by hand from the [BCM2711 ARM Peripherals
datasheet](https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf). Addresses are the
low peripheral view: what the datasheet places at `0x7E000000` the ARM cores see at `0xFE000000`.

- `hal.gpio` covers the 58 pins. Note that the BCM2711 sets the pull resistors directly through
  `GPIO_PUP_PDN_CNTRL_REG`; the clocked `GPPUD` sequence of the BCM2835 and BCM2837 does not carry
  over to this chip.
- `hal.uart` drives the PL011, which the datasheet calls UART0. `apply` routes it onto GPIO14 and
  GPIO15 by putting those pads in alt0, taking the header back from the mini uart and leaving
  bluetooth without a uart. That is the right trade here: unlike the mini uart, the PL011 baud
  rate does not move with the VideoCore core clock.
- `hal.time` reads the ARM generic timer through `CNTPCT_EL0`, so it needs no peripheral setup and
  is not shared with the VideoCore.

## Not here yet

- The GIC-400, so interrupts can only be masked globally.
- The mmu and the caches, which are left off. Every access goes to memory, which is correct but
  slow.
- The firmware mailbox, and with it the framebuffer, the board revision and the gpio expander. The
  green ACT led of a Pi 4B hangs off that expander rather than a BCM gpio, which is why the board
  definition cannot drive it.
- Cores 1 to 3.
- I2C, SPI, PWM, the SD host and USB.
