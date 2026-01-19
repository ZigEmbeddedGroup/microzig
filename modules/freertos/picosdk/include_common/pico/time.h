#ifndef _PICO_TIME_H
#define _PICO_TIME_H

#include "hardware/timer.h"

typedef uint64_t absolute_time_t;

static inline absolute_time_t get_absolute_time(void) {
    absolute_time_t t;
    update_us_since_boot(&t, time_us_64());
    return t;
}

static inline int64_t absolute_time_diff_us(absolute_time_t from, absolute_time_t to) {
    return (int64_t)(to_us_since_boot(to) - to_us_since_boot(from));
}

bool best_effort_wfe_or_timeout(absolute_time_t timeout_timestamp);

#endif