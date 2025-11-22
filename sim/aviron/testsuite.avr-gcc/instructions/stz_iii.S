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

    ; Test ST -Z (pre-decrement) instruction
    ; Z register (r31:r30) initially points to 0x0223

    ; Z = Z - 1, then store r18 to (Z)
    ; Z: 0x0223 -> 0x0222, Memory[0x0222] = 0x66
    st -Z, r18

    ; Z = Z - 1, then store r17 to (Z)
    ; Z: 0x0222 -> 0x0221, Memory[0x0221] = 0x55
    st -Z, r17

    ; Z = Z - 1, then store r16 to (Z)
    ; Z: 0x0221 -> 0x0220, Memory[0x0220] = 0x44
    st -Z, r16

    ; Copy final Z register value (after ST operations) to r23:r24 for verification
    mov r23, r30  ; r23 = Z low byte (should be 0x20)
    mov r24, r31  ; r24 = Z high byte (should be 2)

    ; Read back the values to verify they were stored correctly
    ; Z is now at 0x0220, so read forward
    ld r19, Z+  ; r19 = Memory[0x0220] = 0x44, Z becomes 0x0221
    ld r20, Z+  ; r20 = Memory[0x0221] = 0x55, Z becomes 0x0222
    ld r21, Z+  ; r21 = Memory[0x0222] = 0x66, Z becomes 0x0223
    ld r22, Z+  ; r22 = Memory[0x0223] = 0x00, Z becomes 0x0224

    ; Reset Z to final position after ST operations (0x0220)
    ldi r30, 0x20
    ldi r31, 0x02

    break
