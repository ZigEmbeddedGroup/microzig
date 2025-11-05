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
//!     "r23": 2
//!   }
//! }

    ; Test LD Z (indirect without increment/decrement)
    ; Z register (r31:r30) initially points to 0x0210

    ; First, store test values to memory at different addresses
    st Z+, r16  ; Memory[0x0210] = 0x11, Z becomes 0x0211
    st Z+, r17  ; Memory[0x0211] = 0x22, Z becomes 0x0212
    st Z+, r18  ; Memory[0x0212] = 0x33, Z becomes 0x0213

    ; Reset Z to 0x0210
    ldi r30, 0x10
    ldi r31, 0x02

    ; Load from Z without changing the pointer
    ld r19, Z   ; r19 = Memory[0x0210] = 0x11, Z stays at 0x0210

    ; Manually increment Z to next address
    adiw r30, 1  ; Z becomes 0x0211

    ; Load again from Z
    ld r20, Z   ; r20 = Memory[0x0211] = 0x22, Z stays at 0x0211

    ; Manually increment Z to next address
    adiw r30, 1  ; Z becomes 0x0212

    ; Load again from Z
    ld r21, Z   ; r21 = Memory[0x0212] = 0x33, Z stays at 0x0212

    ; Manually increment Z to next address
    adiw r30, 1  ; Z becomes 0x0213

    ; Load again from Z
    ld r22, Z   ; r22 = Memory[0x0213] = 0x00, Z stays at 0x0213

    ; Verify final Z register value
    mov r23, r31  ; r23 = Z high byte (should be 2)

    break
