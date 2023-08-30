//! {
//!   "exit": "breakpoint",
//!   "cpu":    "attiny816",
//!   "precondition": { "r16": 248, "r17": 243 },
//!   "postcondition": {
//!     "r16": 248, 
//!     "r17": 243, 
//!     "r0": 104, 
//!     "r1": 0, 
//!     "sreg": { "c": false, "z": false } }
//! }

    muls r16, 17
    break
