# Examples for the Port `raspberrypi-bcm2711`

- [Blinky](src/blinky.zig) on a
  [Raspberry Pi 4 Model B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
  Blinks an led on header pin 40 and logs over the serial console.
- [UART echo](src/uart_echo.zig)
  Echoes back what arrives on the serial console.

The green ACT led of a Pi 4B sits behind the VideoCore gpio expander rather than a BCM gpio, so it
cannot be driven from bare metal without the firmware mailbox. Put an led and a resistor between
header pin 40 and ground on pin 39 instead.

The serial console is the PL011 on header pins 8 (TX) and 10 (RX), with ground on pin 6, at
115200 baud. A usb to serial cable on those three pins is enough.

## How to run it on a device

Build, then put the image on the boot partition of a card that already carries the Raspberry Pi
firmware:

```sh
zig build
```

```sh
cp zig-out/firmware/blinky.bin /Volumes/bootfs/kernel8.img
```

`config.txt` on that partition needs at least:

```
arm_64bit=1
kernel=kernel8.img
```
