//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r26": 3,
//!     "r27": 2,
//!     "r16": 221,
//!     "r17": 238,
//!     "r18": 255
//!   },
//!   "postcondition": {
//!     "r16": 221,
//!     "r17": 238,
//!     "r18": 255,
//!     "r19": 221,
//!     "r20": 238,
//!     "r21": 255,
//!     "r22": 0,
//!     "r23": 0,
//!     "r24": 2
//!   }
//! }

    ; Test LD -X (pre-decrement) instruction
    ; X register (r27:r26) initially points to 0x0203

    ; First, store test values to memory using pre-decrement
    st -X, r18  ; X becomes 0x0202, Memory[0x0202] = 0xFF
    st -X, r17  ; X becomes 0x0201, Memory[0x0201] = 0xEE
    st -X, r16  ; X becomes 0x0200, Memory[0x0200] = 0xDD

    ; Copy final X register value to r23:r24 for verification
    mov r23, r26  ; r23 = X low byte (should be 0)
    mov r24, r27  ; r24 = X high byte (should be 2)

    ; Load values back using post-increment to verify they were stored correctly
    ; X is now at 0x0200, so read forward
    ld r19, X+  ; r19 = Memory[0x0200] = 0xDD, X becomes 0x0201
    ld r20, X+  ; r20 = Memory[0x0201] = 0xEE, X becomes 0x0202
    ld r21, X+  ; r21 = Memory[0x0202] = 0xFF, X becomes 0x0203
    ld r22, X+  ; r22 = Memory[0x0203] = 0x00, X becomes 0x0204

    ; Reset X to final position after ST operations (0x0200)
    ldi r26, 0x00
    ldi r27, 0x02

    break
