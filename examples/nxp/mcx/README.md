# Examples for NXP MCX port

All examples:

| Example                          | Description                |
| -------------------------------- |--------------------------- |
| [Blinky](src/blinky.zig)         | A basic LED blink example  |
| [GPIO input](src/gpio_input.zig) | Toggle LED on button press |

## Flashing

You can flash using [NXP's LinkServer](https://www.nxp.com/design/design-center/software/development-software/mcuxpresso-software-and-tools-/linkserver-for-microcontrollers:LINKERSERVER) or [pyOCD](https://pyocd.io/) with a [MCXA CMSIS pack](https://www.keil.arm.com/packs/mcxa153_dfp-nxp/devices/), e.g.:

```sh
zig build -Dexample=blinky -Doptimize=ReleaseSmall

pyocd flash ./zig-out/firmware/blinky.elf --target mcxa153 --quiet
```
