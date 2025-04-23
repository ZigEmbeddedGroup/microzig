//! {
//!   "exit_code": 11
//! }

#include "../regs.inc"

.global _start
_start:

    ldi r16, 11
    out IO_SCRATCH_4, r16

    in r15, IO_SCRATCH_4
    out IO_EXIT, r15
