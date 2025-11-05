//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r30": 16,
//!     "r31": 2,
//!     "r16": 17,
//!     "r17": 34,
//!     "r18": 51,
//!     "r19": 68
//!   },
//!   "postcondition": {
//!     "r16": 17,
//!     "r17": 34,
//!     "r18": 51,
//!     "r19": 68,
//!     "r20": 17,
//!     "r21": 34,
//!     "r22": 51,
//!     "r23": 68,
//!     "r24": 16,
//!     "r25": 2
//!   }
//! }

    ; Test LDD (load with displacement) from Z register
    ; Z register (r31:r30) initially points to 0x0210

    ; First, store test values to memory at different offsets
    std Z+0, r16  ; Memory[0x0210] = 0x11
    std Z+1, r17  ; Memory[0x0211] = 0x22
    std Z+2, r18  ; Memory[0x0212] = 0x33
    std Z+3, r19  ; Memory[0x0213] = 0x44

    ; Verify Z register hasn't changed (displacement doesn't modify pointer)
    mov r24, r30  ; r24 = Z low byte (should still be 0x10)
    mov r25, r31  ; r25 = Z high byte (should still be 2)

    ; Load values back using LDD with displacement
    ldd r20, Z+0  ; r20 = Memory[0x0210] = 0x11
    ldd r21, Z+1  ; r21 = Memory[0x0211] = 0x22
    ldd r22, Z+2  ; r22 = Memory[0x0212] = 0x33
    ldd r23, Z+3  ; r23 = Memory[0x0213] = 0x44

    break
