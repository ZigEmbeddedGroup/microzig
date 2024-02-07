#!/bin/sh

set -e 

root="$(dirname "$(realpath "$0")")"
tmpdir="/tmp/microzig-test"

mkdir -p "${tmpdir}"

examples="espressif/esp stmicro/stm32 nordic/nrf5x gigadevice/gd32 raspberrypi/rp2040 nxp/lpc microchip/atsam"

for key in ${examples}; do
    "${root}/validate-example.py" --build-root "${tmpdir}" --example "$key"
done
