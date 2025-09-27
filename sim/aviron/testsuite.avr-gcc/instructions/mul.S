//! {
//!   "exit": "breakpoint",
//!   "cpu":    "attiny816",
//!   "precondition": { "r16": 80, "r17": 130 },
//!   "postcondition": {
//!     "r16": 80,
//!     "r17": 130,
//!     "r0": 160,
//!     "r1": 40,
//!     "sreg": { "c": false, "z": false } }
//! }

    mul r16, 17 ; => 10400, 0x28A0
    break
