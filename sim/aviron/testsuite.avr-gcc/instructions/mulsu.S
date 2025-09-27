//! {
//!   "exit": "breakpoint",
//!   "cpu":    "attiny816",
//!   "precondition": { "r16": 248, "r17": 243 },
//!   "postcondition": {
//!     "r16": 248,
//!     "r17": 243,
//!     "r0": 104,
//!     "r1": 248,
//!     "sreg": { "c": true, "z": false } }
//! }

    mulsu r16, 17
    break
