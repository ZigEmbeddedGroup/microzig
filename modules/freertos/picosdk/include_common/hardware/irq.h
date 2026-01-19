#ifndef _HARDWARE_IRQ_H
#define _HARDWARE_IRQ_H

#include "hardware/regs/intctrl.h"

typedef void (*irq_handler_t)(void);

void irq_set_priority(uint num, uint8_t hardware_priority);

void irq_set_exclusive_handler(uint num, irq_handler_t handler);

void irq_set_enabled(uint num, bool enabled);

#endif