//! {
//!   "exit_code": 0,
//!   "stdout": "Hello",
//!   "stderr": ""
//! }

#include "../regs.inc"

.global _start
_start:

    ldi r16, 'H'
    out IO_STDOUT, r16
    ldi r16, 'e'
    out IO_STDOUT, r16
    ldi r16, 'l'
    out IO_STDOUT, r16
    out IO_STDOUT, r16
    ldi r16, 'o'
    out IO_STDOUT, r16

    clr r16
    out IO_EXIT, r16
