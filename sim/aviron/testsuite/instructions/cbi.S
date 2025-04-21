//! {
//!   "exit_code": 85
//! }

#include "../regs.inc"

.global _start
_start:
    ldi r16, 0xFF
    out IO_SCRATCH_A, r16

    cbi IO_SCRATCH_A, 1
    cbi IO_SCRATCH_A, 3
    cbi IO_SCRATCH_A, 5
    cbi IO_SCRATCH_A, 7

    in r15, IO_SCRATCH_A
    out IO_EXIT, r15
