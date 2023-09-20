#!/bin/sh

exec ezpkg \
    microzig=/home/felix/projects/zeg/microzig \
    microzig.uf2=/home/felix/projects/zeg/uf2 \
    microzig.regz=/home/felix/projects/zeg/regz \
    rp2040=/home/felix/projects/zeg/device-support-package/rp2040 \
    stm32=/home/felix/projects/zeg/device-support-package/stmicro-stm32
    