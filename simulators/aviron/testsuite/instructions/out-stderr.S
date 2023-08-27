//! {
//!   "exit_code": 0,
//!   "stdout": "",
//!   "stderr": "Hello"
//! }

.global _start
_start:

    ldi r16, 'H'
    out 0x02, r16
    ldi r16, 'e'
    out 0x02, r16
    ldi r16, 'l'
    out 0x02, r16
    out 0x02, r16
    ldi r16, 'o'
    out 0x02, r16

    clr r16
    out 0x00, r16
