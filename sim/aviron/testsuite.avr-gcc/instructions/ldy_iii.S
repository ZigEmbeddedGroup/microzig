//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r28": 3,
//!     "r29": 2,
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

    ; Test LD -Y (pre-decrement) instruction
    ; Y register (r29:r28) initially points to 0x0203

    ; First, store test values to memory using pre-decrement
    st -Y, r18  ; Y becomes 0x0202, Memory[0x0202] = 0xFF
    st -Y, r17  ; Y becomes 0x0201, Memory[0x0201] = 0xEE
    st -Y, r16  ; Y becomes 0x0200, Memory[0x0200] = 0xDD

    ; Copy final Y register value to r23:r24 for verification
    mov r23, r28  ; r23 = Y low byte (should be 0)
    mov r24, r29  ; r24 = Y high byte (should be 2)

    ; Load values back using post-increment to verify they were stored correctly
    ; Y is now at 0x0200, so read forward
    ld r19, Y+  ; r19 = Memory[0x0200] = 0xDD, Y becomes 0x0201
    ld r20, Y+  ; r20 = Memory[0x0201] = 0xEE, Y becomes 0x0202
    ld r21, Y+  ; r21 = Memory[0x0202] = 0xFF, Y becomes 0x0203
    ld r22, Y+  ; r22 = Memory[0x0203] = 0x00, Y becomes 0x0204

    ; Reset Y to final position after ST operations (0x0200)
    ldi r28, 0x00
    ldi r29, 0x02

    break
