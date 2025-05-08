//! {
//!   "exit_code": 0,
//!   "stdout": "",
//!   "stderr": "Hello"
//! }

#include "../regs.inc"

.global _start
_start:

    ldi r16, 'H'
    out IO_STDERR, r16
    ldi r16, 'e'
    out IO_STDERR, r16
    ldi r16, 'l'
    out IO_STDERR, r16
    out IO_STDERR, r16
    ldi r16, 'o'
    out IO_STDERR, r16

    clr r16
    out IO_EXIT, r16
