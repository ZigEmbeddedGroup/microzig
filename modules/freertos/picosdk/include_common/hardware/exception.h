#ifndef _HARDWARE_EXCEPTION_H
#define _HARDWARE_EXCEPTION_H

#include "hardware/address_mapped.h"

enum exception_number {
    // Assigned to VTOR indices
    MIN_EXCEPTION_NUM = 2,
    NMI_EXCEPTION = 2,         ///< Non Maskable Interrupt
    HARDFAULT_EXCEPTION = 3,   ///< HardFault Interrupt
#if PICO_RP2350
    MEMMANAGE_EXCEPTION = 4,   ///< MemManage Interrupt
    BUSFAULT_EXCEPTION = 5,    ///< BusFault Interrupt
    USAGEFAULT_EXCEPTION = 6,  ///< UsageFault Interrupt
    SECUREFAULT_EXCEPTION = 7, ///< SecureFault Interrupt
#endif
    SVCALL_EXCEPTION = 11,     ///< SV Call Interrupt
    PENDSV_EXCEPTION = 14,     ///< Pend SV Interrupt
    SYSTICK_EXCEPTION = 15,    ///< System Tick Interrupt
    MAX_EXCEPTION_NUM = 15
};

typedef void (*exception_handler_t)(void);

exception_handler_t exception_set_exclusive_handler(enum exception_number num, exception_handler_t handler);

#endif