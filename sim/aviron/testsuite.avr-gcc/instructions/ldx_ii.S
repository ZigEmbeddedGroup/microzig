//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r26": 0,
//!     "r27": 2,
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

    ; Test LD X+ (post-increment) instruction
    ; X register (r27:r26) initially points to 0x0200

    ; First, store test values to memory
    st X+, r16  ; Memory[0x0200] = 0xAA, X becomes 0x0201
    st X+, r17  ; Memory[0x0201] = 0xBB, X becomes 0x0202
    st X+, r18  ; Memory[0x0202] = 0xCC, X becomes 0x0203

    ; Copy final X register value to r23:r24 for verification
    mov r23, r26  ; r23 = X low byte (should be 3)
    mov r24, r27  ; r24 = X high byte (should be 2)

    ; Reset X back to 0x0200 to test LD
    ldi r26, 0x00
    ldi r27, 0x02

    ; Load values back using LD X+ instruction
    ld r19, X+  ; r19 = Memory[0x0200] = 0xAA, X becomes 0x0201
    ld r20, X+  ; r20 = Memory[0x0201] = 0xBB, X becomes 0x0202
    ld r21, X+  ; r21 = Memory[0x0202] = 0xCC, X becomes 0x0203
    ld r22, X+  ; r22 = Memory[0x0203] = 0x00, X becomes 0x0204

    break
