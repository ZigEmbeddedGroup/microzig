#!/bin/bash

set -e

mount /dev/sdb /mnt
cp ./zig-cache/bin/firmware.bin /mnt/firmware.bin
umount /mnt