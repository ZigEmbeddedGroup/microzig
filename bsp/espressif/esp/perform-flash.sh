#!/bin/bash

set -e

clear
zig build -Doptimize=ReleaseSmall
llvm-objdump -S ./zig-out/bin/esp-bringup > /tmp/dump.txt
esptool.py \
  --port /dev/ttyUSB0 \
  --baud 115200 \
  write_flash 0x00000000 zig-out/firmware/blinky.bin \
  --verify
picocom --baud 115200 /dev/ttyUSB0