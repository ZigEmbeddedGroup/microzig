#!/bin/sh

exec ezpkg \
    microzig=/home/felix/projects/zeg/microzig \
    microzig.uf2=/home/felix/projects/zeg/uf2 \
    microzig.regz=/home/felix/projects/zeg/regz \
    rp2040=/home/felix/projects/zeg/device-support-package/rp2040 \
    stm32=/home/felix/projects/zeg/device-support-package/stmicro-stm32 \
    lpc=/home/felix/projects/zeg/device-support-package/nxp-lpc \
    gd32=/home/felix/projects/zeg/device-support-package/gigadevice-gd32 \
    esp=/home/felix/projects/zeg/device-support-package/espressif-esp \
    nrf5x=/home/felix/projects/zeg/device-support-package/nordic-nrf5x \
    atmega=/home/felix/projects/zeg/device-support-package/microchip-atmega 