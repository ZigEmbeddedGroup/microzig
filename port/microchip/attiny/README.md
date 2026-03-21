# Microchip ATtiny Hardware Support Package

## Supported Chips

- ATtiny85
- ATtiny84

## FYI: LLVM issues

Currently LLVM is having trouble lowering AVR when this is built in debug mode.

For now always build in release small:

```
zig build -Doptimize=ReleaseSmall
```
