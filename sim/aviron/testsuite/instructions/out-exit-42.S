//! {
//!   "exit_code": 42,
//!   "stdout": "",
//!   "stderr": ""
//! }

#include "../regs.inc"

.global _start
_start:
    ldi r16, 42
    out IO_EXIT, r16
