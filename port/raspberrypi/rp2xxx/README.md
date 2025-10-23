# raspberrypi-rp2xxx

HAL and register definitions for the RP2040 and RP2350 chips.

## RP2350 Status

The RP2350 is very similar to the RP2040, but has enough differences to require an audit of all HAL code for compatibility. The following tracks what has been verified to work on the RP2350 as compared to the RP2040:
- [x] adc
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
- [x] pwm
- [x] random
- [x] resets
- [ ] rom
- [ ] spi
- [x] time
- [x] uart
- [x] usb
- [x] watchdog