//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r28": 0,
//!     "r29": 2,
//!     "r16": 170,
//!     "r17": 187,
//!     "r18": 204,
//!     "r19": 221
//!   },
//!   "postcondition": {
//!     "r16": 170,
//!     "r17": 187,
//!     "r18": 204,
//!     "r19": 221,
//!     "r20": 170,
//!     "r21": 187,
//!     "r22": 204,
//!     "r23": 221,
//!     "r24": 0,
//!     "r25": 2
//!   }
//! }

    ; Test LDD (load with displacement) from Y register
    ; Y register (r29:r28) initially points to 0x0200

    ; First, store test values to memory at different offsets
    std Y+0, r16  ; Memory[0x0200] = 0xAA
    std Y+1, r17  ; Memory[0x0201] = 0xBB
    std Y+2, r18  ; Memory[0x0202] = 0xCC
    std Y+3, r19  ; Memory[0x0203] = 0xDD

    ; Verify Y register hasn't changed (displacement doesn't modify pointer)
    mov r24, r28  ; r24 = Y low byte (should still be 0)
    mov r25, r29  ; r25 = Y high byte (should still be 2)

    ; Load values back using LDD with displacement
    ldd r20, Y+0  ; r20 = Memory[0x0200] = 0xAA
    ldd r21, Y+1  ; r21 = Memory[0x0201] = 0xBB
    ldd r22, Y+2  ; r22 = Memory[0x0202] = 0xCC
    ldd r23, Y+3  ; r23 = Memory[0x0203] = 0xDD

    break
