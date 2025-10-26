//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r30": 16,
//!     "r31": 2,
//!     "r16": 17,
//!     "r17": 34,
//!     "r18": 51
//!   },
//!   "postcondition": {
//!     "r16": 17,
//!     "r17": 34,
//!     "r18": 51,
//!     "r19": 17,
//!     "r20": 34,
//!     "r21": 51,
//!     "r22": 0,
//!     "r23": 19,
//!     "r24": 2
//!   }
//! }

    ; Test LD Z+ (post-increment) instruction
    ; Z register (r31:r30) initially points to 0x0210

    ; First, store test values to memory
    st Z+, r16  ; Memory[0x0210] = 0x11, Z becomes 0x0211
    st Z+, r17  ; Memory[0x0211] = 0x22, Z becomes 0x0212
    st Z+, r18  ; Memory[0x0212] = 0x33, Z becomes 0x0213

    ; Copy final Z register value to r23:r24 for verification
    mov r23, r30  ; r23 = Z low byte (should be 0x13)
    mov r24, r31  ; r24 = Z high byte (should be 2)

    ; Reset Z back to 0x0210 to test LD
    ldi r30, 0x10
    ldi r31, 0x02

    ; Load values back using LD Z+ instruction
    ld r19, Z+  ; r19 = Memory[0x0210] = 0x11, Z becomes 0x0211
    ld r20, Z+  ; r20 = Memory[0x0211] = 0x22, Z becomes 0x0212
    ld r21, Z+  ; r21 = Memory[0x0212] = 0x33, Z becomes 0x0213
    ld r22, Z+  ; r22 = Memory[0x0213] = 0x00, Z becomes 0x0214

    break
