//! {
//!   "exit_code": 170
//! }

#include "../regs.inc"

.global _start
_start:
    clr r16
    out IO_SCRATCH_A, r16

    sbi IO_SCRATCH_A, 1
    sbi IO_SCRATCH_A, 3
    sbi IO_SCRATCH_A, 5
    sbi IO_SCRATCH_A, 7

    in r15, IO_SCRATCH_A
    out IO_EXIT, r15
