#ifndef _PICO_H
#define _PICO_H

#include "pico/platform.h"

// Microzig Hack, so port can compile when configNUMBER_OF_CORES is 1 otherwise port include lock_core.h that already includes this file
#include "hardware/structs/sio.h"
// Simmilar hack but for RP2350 port
#include "pico/multicore.h"

#endif