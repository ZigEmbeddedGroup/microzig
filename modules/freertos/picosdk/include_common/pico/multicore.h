#ifndef _PICO_MULTICORE_H
#define _PICO_MULTICORE_H

#include "hardware/structs/sio.h"

void multicore_reset_core1(void);

void multicore_launch_core1(void (*entry)(void));

static inline bool multicore_fifo_rvalid(void) {
    return sio_hw->fifo_st & SIO_FIFO_ST_VLD_BITS;
}

static inline void multicore_fifo_drain(void) {
    while (multicore_fifo_rvalid())
        (void) sio_hw->fifo_rd;
}

static inline void multicore_fifo_clear_irq(void) {
    // Write any value to clear the error flags
    sio_hw->fifo_st = 0xff;
}

#if NUM_DOORBELLS

static inline void multicore_doorbell_set_other_core(uint doorbell_num) {
    sio_hw->doorbell_out_set = 1u << doorbell_num;
}

#endif

#endif