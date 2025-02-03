#pragma once

// TODO: Exercise more? delays, optional sideset, etc?
static const uint16_t irq_program_instructions[] = {
    0xc009, // irq set    1 prev          side 0
    0xc011, // irq set    1 rel           side 0
    0xc019, // irq set    1 next          side 0
    0xc029, // irq wait   1 prev          side 0
    0xc031, // irq wait   1 rel           side 0
    0xc039, // irq wait   1 next          side 0
    0xc049, // irq clear  1 prev          side 0
    0xc051, // irq clear  1 rel           side 0
    0xc059, // irq clear  1 next          side 0
};
