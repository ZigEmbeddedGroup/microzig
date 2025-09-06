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
//!     "r16": 42,
//!     "r17": 170,
//!     "r18": 42,
//!     "r19": 170,
//!     "sreg": { "c": false, "n": true, "s": false } }
//! }

    ; Precondition: r16 = 0x55, c true
    ; Postcondition: r16 = 0x2A, c true
    lsr r16
    ; Precondition: r17 = 0x55, c true
    ; Postcondition: r17 = 0xAA, c false
    lsl r17
    ; Precondition: r18 = 0x55, c false
    ; Postcondition: r18 = 0x2A, c true
    lsr r18
    ; Precondition: r19 = 0x55, c true
    ; Postcondition: r19 = 0xAA, c false
    lsl r19
    break
