//! {
//!   "exit_code": 11
//! }

#include "../regs.inc"

.global _start
_start:

    ldi r16, 11
    out IO_SCRATCH_A, r16

    in r15, IO_SCRATCH_A
    out IO_EXIT, r15
