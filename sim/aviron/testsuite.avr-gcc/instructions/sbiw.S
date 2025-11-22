//! {
//!   "exit": "breakpoint",
//!   "cpus": ["atmega2560", "atmega328p"],
//!   "precondition": {
//!     "r24": 0,
//!     "r25": 0,
//!     "r26": 0,
//!     "r27": 128,
//!     "r28": 8,
//!     "r29": 0,
//!     "r30": 255,
//!     "r31": 255 },
//!   "postcondition": {
//!     "r16": 21,
//!     "r17": 24,
//!     "r18": 2,
//!     "r19": 20,
//!     "r24": 248,
//!     "r25": 255,
//!     "r26": 255,
//!     "r27": 127,
//!     "r28": 0,
//!     "r29": 0,
//!     "r30": 192,
//!     "r31": 255 }
//! }

    ; Test case 1: 0x0000 - 0x08 = 0xFFF8
    ; Precondition: r25:r24 = 0x0000
    ; Expected: r25:r24 = 0xFFF8, C=1, N=1, V=0, S=1, Z=0
    ; SREG should be 0x15 (C=1, Z=0, N=1, V=0, S=1)
    sbiw r24, 0x8
    in r16, 0x3F    ; Save SREG to r16

    ; Test case 2: 0x8000 - 0x01 = 0x7FFF (overflow)
    ; Precondition: r27:r26 = 0x8000
    ; Expected: r27:r26 = 0x7FFF, C=0, N=0, V=1, S=1, Z=0
    ; SREG should be 0x18 (C=0, Z=0, N=0, V=1, S=1)
    sbiw r26, 0x1
    in r17, 0x3F    ; Save SREG to r17

    ; Test case 3: 0x0008 - 0x08 = 0x0000 (zero result)
    ; Precondition: r29:r28 = 0x0008
    ; Expected: r29:r28 = 0x0000, C=0, N=0, V=0, S=0, Z=1
    ; SREG should be 0x02 (C=0, Z=1, N=0, V=0, S=0)
    sbiw r28, 0x8
    in r18, 0x3F    ; Save SREG to r18

    ; Test case 4: 0xFFFF - 0x3F = 0xFFC0
    ; Precondition: r31:r30 = 0xFFFF
    ; Expected: r31:r30 = 0xFFC0, C=0, N=1, V=0, S=1, Z=0
    ; SREG should be 0x14 (C=0, Z=0, N=1, V=0, S=1)
    sbiw r30, 0x3F
    in r19, 0x3F    ; Save SREG to r19

    break
