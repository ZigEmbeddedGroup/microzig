//! {
//!   "exit": "breakpoint",
//!   "cpu":    "attiny816",
//!   "precondition": {
//!     "r16": 85,
//!     "r17": 170,
//!     "r18": 170,
//!     "sreg": { "c": true } },
//!   "postcondition": {
//!     "r16": 42,
//!     "r17": 213,
//!     "r18": 234,
//!     "sreg": { "c": true, "n": true, "s": true } }
//! }

    ; Precondition: r16 = 0x55, c true
    ; Postcondition: r16 = 0x2A, c true
    asr r16
    ; Precondition: r17 = 0xAA, c true
    ; Postcondition: r17 = 0xD5, c true
    asr r17
    ; Precondition: r18 = 0xAA, c true
    ; Postcondition: r18 = 0xEA, c true
    asr r18
    asr r18
    break
