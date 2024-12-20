#pragma once

static const uint16_t movrx_program_instructions[] = {
    // 0b1000_ssss_0001_yiii
    0x8018, // mov rxfifoy, isr
    0x8010, // mov rxfifo0, isr
    0x8011, // mov rxfifo1, isr
    0x8012, // mov rxfifo2, isr
    0x8013, // mov rxfifo3, isr
            // 0b1000_ssss_1001_yiii
            // 0x8098, // mov osr, rxfifoy
            // 0x8090, // mov osr, rxfifo0
            // 0x8091, // mov osr, rxfifo1
            // 0x8092, // mov osr, rxfifo2
            // 0x8093, // mov osr, rxfifo3
};
