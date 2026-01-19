#ifndef _HARDWARE_TIMER_H
#define _HARDWARE_TIMER_H

#include "hardware/address_mapped.h"

uint64_t time_us_64();

bool time_reached(absolute_time_t t);

#endif