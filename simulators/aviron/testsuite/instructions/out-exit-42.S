//! {
//!   "exit_code": 42,
//!   "stdout": "",
//!   "stderr": ""
//! }

.global _start
_start:
    ldi r16, 42
    out 0x00, r16
