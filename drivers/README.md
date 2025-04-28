# microzig-driver-framework

A collection of device drivers for the use with MicroZig.

## Drivers

> Drivers with a checkmark are already implemented, drivers without are missing

- Input
  - [x] Keyboard Matrix
  - [x] Rotary Encoder
  - [x] Debounced Button
  - Touch
    - [ ] [XPT2046](https://github.com/ZigEmbeddedGroup/microzig/issues/247)
- Display
  - [x] SSD1306 (I²C works, [3-wire SPI](https://github.com/ZigEmbeddedGroup/microzig/issues/251) and [4-wire SPI](https://github.com/ZigEmbeddedGroup/microzig/issues/252) are missing)
  - [ ] [ST7735](https://github.com/ZigEmbeddedGroup/microzig/issues/250) (WIP)
  - [ ] [ILI9488](https://github.com/ZigEmbeddedGroup/microzig/issues/249)
- Wireless
  - [ ] CYW43 (WIP)
  - [ ] [SX1276, SX1278](https://github.com/ZigEmbeddedGroup/microzig/issues/248)
- Stepper
  - [x] A4988
  - [x] DRV8825 (Implemented but untested)
