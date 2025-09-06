//! {
//!   "exit": "breakpoint",
//!   "cpu":    "attiny816",
//!   "precondition": {
//!     "r16": 85,
//!     "r17": 85,
//!     "r18": 85,
//!     "r19": 85,
//!     "sreg": { "c": true } },
//!   "postcondition": {
//!     "r16": 170,
//!     "r17": 171,
//!     "r18": 42,
//!     "r19": 170,
//!     "sreg": { "c": false, "n": true, "s": false } }
//! }

    ; Precondition: r16 = 0x55, c true
    ; Postcondition: r16 = 0xAA, c true
    ror r16
    ; Precondition: r17 = 0x55, c true
    ; Postcondition: r17 = 0xAB, c true
    rol r17
    ; Precondition: r18 = 0x55, c false
    ; Postcondition: r18 = 0x2A, c true
    ror r18
    clc
    ; Precondition: r19 = 0x55, c false
    ; Postcondition: r19 = 0xAA, c false
    rol r19
    break
