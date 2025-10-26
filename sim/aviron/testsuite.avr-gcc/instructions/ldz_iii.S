//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega328p", "atmega2560"],
//!   "precondition": {
//!     "r30": 35,
//!     "r31": 2,
//!     "r16": 68,
//!     "r17": 85,
//!     "r18": 102
//!   },
//!   "postcondition": {
//!     "r16": 68,
//!     "r17": 85,
//!     "r18": 102,
//!     "r19": 68,
//!     "r20": 85,
//!     "r21": 102,
//!     "r22": 0,
//!     "r23": 32,
//!     "r24": 2
//!   }
//! }

    ; Test LD -Z (pre-decrement) instruction
    ; Z register (r31:r30) initially points to 0x0223

    ; First, store test values to memory using pre-decrement
    st -Z, r18  ; Z becomes 0x0222, Memory[0x0222] = 0x66
    st -Z, r17  ; Z becomes 0x0221, Memory[0x0221] = 0x55
    st -Z, r16  ; Z becomes 0x0220, Memory[0x0220] = 0x44

    ; Copy final Z register value to r23:r24 for verification
    mov r23, r30  ; r23 = Z low byte (should be 0x20)
    mov r24, r31  ; r24 = Z high byte (should be 2)

    ; Reset Z to 0x0223 to test LD -Z
    ldi r30, 0x23
    ldi r31, 0x02

    ; Load values back using LD -Z instruction
    ld r21, -Z  ; Z becomes 0x0222, r21 = Memory[0x0222] = 0x66
    ld r20, -Z  ; Z becomes 0x0221, r20 = Memory[0x0221] = 0x55
    ld r19, -Z  ; Z becomes 0x0220, r19 = Memory[0x0220] = 0x44
    ld r22, -Z  ; Z becomes 0x021F, r22 = Memory[0x021F] = 0x00

    ; Reset Z to final position (0x0220)
    ldi r30, 0x20
    ldi r31, 0x02

    break
