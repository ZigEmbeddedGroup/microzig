# Microchip ATmega Hardware Support Package

Note: for testing, renode supports arduino nano 33 BLE

## FYI: LLVM issues

Currently LLVM is having trouble lowering AVR when this is built in debug mode:

```
LLVM Emit Object... Don't know how to custom lower this!
UNREACHABLE executed at /Users/mattnite/code/llvm-project-15/llvm/lib/Target/AVR/AVRISelLowering.cpp:842!
```

for now always build in release small:

```
zig build -Doptimize=ReleaseSmall
```
