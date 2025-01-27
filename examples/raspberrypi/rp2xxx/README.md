# Examples for the BSP `raspberrypi-rp2xxx`

## Demos

Demos are divided into two categories:
- Those that can be compiled for/run on both RP2040 (Pico 1) and RP2350 (Pico 2) with no code changes
- Those that are ONLY for a specific chip, RP2040 or RP2350 due to a unique feature present on one but not the other

Currently many demos are marked as "RP2040 only" simply because HAL functionality hasn't been ported to the RP2350 given it's a very new chip. Most
examples will eventually be able to run on either chip with no changes due to their peripherals being extremely similar. All demos that run on the the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board can also be run on the [RP2040-Plus](https://www.waveshare.com/rp2040-plus.htm) without modification.


### Chip Agnostic
- [blinky](src/blinky.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Pico2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) boards  
  Blinks the LED on the board.
- [changing system clocks](src/rp2040_only/changing_system_clocks.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Pico2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) boards  
  Shows an example of changing SYS and REF clock frequencies.
- [custom clock config](src/rp2040_only/custom_clock_config.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Pico2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) boards  
  Shows an example of a fully custom clock configuration.
- [gpio clock output](src/gpio_clock_output.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Pico2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) boards  
  Routes the SYS clock divided by 1000 out to GPIO25.
- [watchdog timer](src/watchdog_timer.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Pico2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) boards  
  Enables a watchdog timer for 1 second, and demonstrates the chip resetting when the watchdog timer elapses
- [usb device](src/usb_cdc.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Pico2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) boards  
  A really basic example for a raw USB device. You can use the Python 3 script [`scripts/usb_device_loopback.py`](scripts/usb_device_loopback.py) to test the USB device.

### RP2040 Only

- [adc](src/rp2040_only/adc.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  This example takes periodic samples of the temperature sensor and prints it to the UART using the stdlib logging facility.
- [blinky core1](src/rp2040_only/blinky_core1.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Blinks the LED on the board using the second CPU.
- [flash program](src/rp2040_only/flash_program.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Writes and reads data into the flash.
- [i2c bus scan](src/rp2040_only/i2c_bus_scan.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Prints all I²C devices on UART0 (Pin 0,1) attached to I²C on SCL=GPIO4, SDA=GPIO5.
- [pwm](src/rp2040_only/pwm.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Slowly blinks the LED on the Pico with a smooth blinking using PWM.
- [random](src/rp2040_only/random.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Showcases how to use the internal random generator.
- [spi host](src/rp2040_only/spi_host.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Showcases how to use the SPI host controller.
- [squarewave](src/squarewave.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Showcases how to use the PIO to emit a basic square wave.
- [uart](src/rp2040_only/uart.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Showcases how to use the UART together with `std.log`.
- [usb hid](src/rp2040_only/usb_hid.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  A really basic example how to implement a USB HID device. You can use the Python 3 script [`scripts/hid_test.py`](scripts/hid_test.py) to test the HID device.
- [ws2812](src/ws2812.zig) on the [Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) board  
  Showcases how to control one WS2812 LED attached to GPIO23.
- [tiles](src/rp2040_only/tiles.zig) on the [RP2040-Matrix](https://www.waveshare.com/rp2040-matrix.htm) board  
  Showcases how to control the LED matrix on the development board to do a simple color flipper effect.

### RP2350 Only
None for now! But an HSTX or other new feature example could go here in the future.

## Flashing

You can flash all examples using either your file browser by dragging the example `.uf2` file from `zig-out/firmware/` to the directory.

Or you can use [`picotool`](https://github.com/raspberrypi/picotool) to flash a uf2 file:
```sh-session
[user@host] raspberrypi-rp2040/ $ picotool load -x zig-out/firmware/${file}.uf2
Loading into Flash: [==============================]  100%

The device was rebooted to start the application.
[user@host] raspberrypi-rp2040/ $ 
```

