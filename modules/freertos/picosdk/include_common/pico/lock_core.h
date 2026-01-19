#ifndef _PICO_LOCK_CORE_H
#define _PICO_LOCK_CORE_H

#include "pico/time.h"

struct lock_core {
    // spin lock protecting this lock's state
    spin_lock_t *spin_lock;

    // note any lock members in containing structures need not be volatile;
    // they are protected by memory/compiler barriers when gaining and release spin locks
};

typedef struct lock_core lock_core_t;

#endif