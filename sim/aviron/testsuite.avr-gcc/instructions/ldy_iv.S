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
//!     "r23": 2
//!   }
//! }

    ; Test LD Y (indirect without increment/decrement)
    ; Y register (r29:r28) initially points to 0x0200

    ; First, store test values to memory at different addresses
    st Y+, r16  ; Memory[0x0200] = 0xAA, Y becomes 0x0201
    st Y+, r17  ; Memory[0x0201] = 0xBB, Y becomes 0x0202
    st Y+, r18  ; Memory[0x0202] = 0xCC, Y becomes 0x0203

    ; Reset Y to 0x0200
    ldi r28, 0x00
    ldi r29, 0x02

    ; Load from Y without changing the pointer
    ld r19, Y   ; r19 = Memory[0x0200] = 0xAA, Y stays at 0x0200

    ; Manually increment Y to next address
    adiw r28, 1  ; Y becomes 0x0201

    ; Load again from Y
    ld r20, Y   ; r20 = Memory[0x0201] = 0xBB, Y stays at 0x0201

    ; Manually increment Y to next address
    adiw r28, 1  ; Y becomes 0x0202

    ; Load again from Y
    ld r21, Y   ; r21 = Memory[0x0202] = 0xCC, Y stays at 0x0202

    ; Manually increment Y to next address
    adiw r28, 1  ; Y becomes 0x0203

    ; Load again from Y
    ld r22, Y   ; r22 = Memory[0x0203] = 0x00, Y stays at 0x0203

    ; Verify final Y register value
    mov r23, r29  ; r23 = Y high byte (should be 2)

    break
