/*
 * Copyright (c) 2021 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#ifndef _BOOT2_HELPER_WAIT_QMI_READY
#define _BOOT2_HELPER_WAIT_QMI_READY

wait_qmi_ready:
    push {r0, r1, lr}

    // Simple delay loop for QMI direct mode operations
    // QMI does not expose a direct busy flag like SSI_SR_BUSY
    // This provides a short delay to allow hardware to complete the transfer
    movs r1, #200
1:
    subs r1, r1, #1
    bne 1b

    pop {r0, r1, pc}

#endif
