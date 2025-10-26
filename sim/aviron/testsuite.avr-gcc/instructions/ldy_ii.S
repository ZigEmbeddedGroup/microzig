//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r28": 0,
//!     "r29": 2,
//!     "r16": 170,
//!     "r17": 187,
//!     "r18": 204
//!   },
//!   "postcondition": {
//!     "r16": 170,
//!     "r17": 187,
//!     "r18": 204,
//!     "r19": 170,
//!     "r20": 187,
//!     "r21": 204,
//!     "r22": 0,
//!     "r23": 3,
//!     "r24": 2
//!   }
//! }

    ; Test LD Y+ (post-increment) instruction
    ; Y register (r29:r28) initially points to 0x0200

    ; First, store test values to memory
    st Y+, r16  ; Memory[0x0200] = 0xAA, Y becomes 0x0201
    st Y+, r17  ; Memory[0x0201] = 0xBB, Y becomes 0x0202
    st Y+, r18  ; Memory[0x0202] = 0xCC, Y becomes 0x0203

    ; Copy final Y register value to r23:r24 for verification
    mov r23, r28  ; r23 = Y low byte (should be 3)
    mov r24, r29  ; r24 = Y high byte (should be 2)

    ; Reset Y back to 0x0200 to test LD
    ldi r28, 0x00
    ldi r29, 0x02

    ; Load values back using LD Y+ instruction
    ld r19, Y+  ; r19 = Memory[0x0200] = 0xAA, Y becomes 0x0201
    ld r20, Y+  ; r20 = Memory[0x0201] = 0xBB, Y becomes 0x0202
    ld r21, Y+  ; r21 = Memory[0x0202] = 0xCC, Y becomes 0x0203
    ld r22, Y+  ; r22 = Memory[0x0203] = 0x00, Y becomes 0x0204

    break
