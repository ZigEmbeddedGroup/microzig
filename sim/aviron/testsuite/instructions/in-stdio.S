//! {
//!   "exit_code": 0,
//!   "stdin": "14325",
//!   "stdout": "14325"
//! }

#include "../regs.inc"

.global _start
_start:

    in r16, IO_STDIN
    out IO_STDOUT, r16

    in r16, IO_STDIN
    out IO_STDOUT, r16

    in r16, IO_STDIN
    out IO_STDOUT, r16

    in r16, IO_STDIN
    out IO_STDOUT, r16

    in r16, IO_STDIN
    out IO_STDOUT, r16

    clr r16
    out IO_EXIT, r16
