//! {
//!   "exit_code": 0,
//!   "stdout": "",
//!   "stderr": ""
//! }

#include "../regs.inc"

.global _start
_start:
    clr r16
    out IO_EXIT, r16
