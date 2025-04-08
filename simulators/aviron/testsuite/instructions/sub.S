//! {
//!   "exit_code": 0,
//!   "stdout": "",
//!   "stderr": "Hi"
//! }

#include "../regs.inc"

.global _start
_start:

    ; 'q' - ')' = 'H'
    ldi r16, 'q'
    ldi r18, ')'
    sub r16, r18
    out IO_STDERR, r16
    ldi r16, 0x80
    ldi r18, 0x80
    add r16, r18
    ; '~' - 0x14 - carry = 'i'
    ldi r17, '~'
    ldi r19, 0x14
    sbc r17, r19
    out IO_STDERR, r17

    clr r16
    out IO_EXIT, r16
