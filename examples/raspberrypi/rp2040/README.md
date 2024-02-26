# Examples for the BSP `raspberrypi-rp2040`

## Demos

All demos that run on the [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) can also be run on the [RP2040-Plus](https://www.waveshare.com/rp2040-plus.htm) without modification.

- [adc](src/adc.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  This example takes periodic samples of the temperature sensor and prints it to the UART using the stdlib logging facility.
- [blinky](src/blinky.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Blinks the LED on the board.
- [blinky core1](src/blinky_core1.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Blinks the LED on the board using the second CPU.
- [flash program](src/flash_program.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Writes and reads data into the flash.
- [gpio clk](src/gpio_clk.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Enables a `CLKOUT` mode on GPIO0.
- [i2c bus scan](src/i2c_bus_scan.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Prints all I²C devices on UART0 (Pin 0,1) attached to I²C on SCL=GPIO4, SDA=GPIO5.
- [pwm](src/pwm.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Slowly blinks the LED on the Pico with a smooth blinking using PWM.
- [random](src/random.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Showcases how to use the internal random generator.
- [spi master](src/spi_master.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Showcases how to use the SPI host controller.
- [squarewave](src/squarewave.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Showcases how to use the PIO to emit a basic square wave.
- [uart](src/uart.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Showcases how to use the UART together with `std.log`.
- [usb device](src/usb_device.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  A really basic example for a raw USB device. You can use the Python 3 script [`scripts/usb_device_loopback.py`](scripts/usb_device_loopback.py) to test the USB device.
- [usb hid](src/usb_hid.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  A really basic example how to implement a USB HID device. You can use the Python 3 script [`scripts/hid_test.py`](scripts/hid_test.py) to test the HID device.
- [ws2812](src/ws2812.zig) on [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)  
  Showcases how to control one WS2812 LED attached to GPIO23.
- [tiles](src/tiles.zig) on [RP2040-Matrix](https://www.waveshare.com/rp2040-matrix.htm)  
  Showcases how to control the LED matrix on the development board to do a simple color flipper effect.

## Flashing

You can flash all examples using either your file browser by dragging the example `.uf2` file from `zig-out/firmware/` to the directory.

Or you can use [`picotool`](https://github.com/raspberrypi/picotool) to flash a uf2 file:
```sh-session
[user@host] raspberrypi-rp2040/ $ picotool load -x zig-out/firmware/${file}.uf2
Loading into Flash: [==============================]  100%

The device was rebooted to start the application.
[user@host] raspberrypi-rp2040/ $ 
```

