#pragma once

static const uint16_t movrx_program_instructions[] = {
    // 0b1000_0000_0001_Iiii (I = IdxI)
    0x8010, // mov rxfifo[y], isr
    0x8018, // mov rxfifo[0], isr
    0x8019, // mov rxfifo[1], isr
    0x801a, // mov rxfifo[2], isr
    0x801b, // mov rxfifo[3], isr
    // 0b1000_0000_1001_Iiii (I = IdxI)
    0x8090, // mov osr, rxfifo[y]
    0x8098, // mov osr, rxfifo[0]
    0x8099, // mov osr, rxfifo[1]
    0x809a, // mov osr, rxfifo[2]
    0x809b, // mov osr, rxfifo[3]
};
