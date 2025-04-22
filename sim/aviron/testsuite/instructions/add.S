//! {
//!   "exit_code": 0,
//!   "stdout": "",
//!   "stderr": "Hi"
//! }

#include "../regs.inc"

.global _start
_start:

    ; '\' + '!' = 'H'
    ldi r16, '\''
    ldi r18, '!'
    add r16, r18
    out IO_STDERR, r16
    ldi r16, 0x80
    ldi r18, 0x80
    add r16, r18
    ; '4' + '4' + carry = 'i'
    ldi r17, '4'
    ldi r19, '4'
    adc r17, r19
    out IO_STDERR, r17

    clr r16
    out IO_EXIT, r16
