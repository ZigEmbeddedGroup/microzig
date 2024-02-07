#!/bin/sh

set -e 

root="$(dirname "$(realpath "$0")")"

examples="espressif/esp stmicro/stm32 nordic/nrf5x gigadevice/gd32 raspberrypi/rp2040 nxp/lpc microchip/atsam" # microchip/avr (does not build with 0.11)

for key in ${examples}; do
    "${root}/validate-example.py" --example "$key" "$@"
done
