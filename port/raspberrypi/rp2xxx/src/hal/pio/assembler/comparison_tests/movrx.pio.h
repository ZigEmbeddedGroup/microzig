#pragma once

static const uint16_t movrx_program_instructions[] = {
    // 0b1000_ssss_0001_yiii
    0x8010, // mov rxfifoy, isr
    0x8018, // mov rxfifo0, isr
    0x8019, // mov rxfifo1, isr
    0x801a, // mov rxfifo2, isr
    0x801b, // mov rxfifo3, isr
    // 0b1000_ssss_1001_yiii
    0x8090, // mov osr, rxfifoy
    0x8098, // mov osr, rxfifo0
    0x8099, // mov osr, rxfifo1
    0x809a, // mov osr, rxfifo2
    0x809b, // mov osr, rxfifo3
};
