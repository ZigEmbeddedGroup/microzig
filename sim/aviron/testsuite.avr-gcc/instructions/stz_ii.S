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

    ; Test ST Z+ (post-increment) instruction
    ; Z register (r31:r30) initially points to 0x0210

    ; Store r16 to (Z), then Z = Z + 1
    ; Z: 0x0210 -> 0x0211, Memory[0x0210] = 0x11
    st Z+, r16

    ; Store r17 to (Z), then Z = Z + 1
    ; Z: 0x0211 -> 0x0212, Memory[0x0211] = 0x22
    st Z+, r17

    ; Store r18 to (Z), then Z = Z + 1
    ; Z: 0x0212 -> 0x0213, Memory[0x0212] = 0x33
    st Z+, r18

    ; Copy final Z register value (after ST operations) to r23:r24 for verification
    mov r23, r30  ; r23 = Z low byte (should be 0x13)
    mov r24, r31  ; r24 = Z high byte (should be 2)

    ; Read back the values to verify they were stored correctly
    ; Set Z back to 0x0210 to read the values
    ldi r30, 0x10
    ldi r31, 0x02

    ; Load values back into r19, r20, r21 for verification
    ld r19, Z+  ; r19 = Memory[0x0210] = 0x11, Z becomes 0x0211
    ld r20, Z+  ; r20 = Memory[0x0211] = 0x22, Z becomes 0x0212
    ld r21, Z+  ; r21 = Memory[0x0212] = 0x33, Z becomes 0x0213
    ld r22, Z+  ; r22 = Memory[0x0213] = 0x00, Z becomes 0x0214

    break
