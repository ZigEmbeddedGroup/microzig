/*
 * Copyright (c) 2021 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#ifndef _BOOT2_HELPER_READ_FLASH_SREG
#define _BOOT2_HELPER_READ_FLASH_SREG

#include "wait_qmi_ready.S"

// Pass status read cmd into r0.
// Returns status value in r0.
.global read_flash_sreg
.type read_flash_sreg,%function
.thumb_func
read_flash_sreg:
    push {r1, lr}
    str r0, [r3, #QMI_DIRECT_TX_OFFSET]
    // Dummy byte:
    str r0, [r3, #QMI_DIRECT_TX_OFFSET]
    
    bl wait_qmi_ready
    // Discard first byte and combine the next two
    ldr r0, [r3, #QMI_DIRECT_RX_OFFSET]
    ldr r0, [r3, #QMI_DIRECT_RX_OFFSET]

    pop {r1, pc}

#endif
