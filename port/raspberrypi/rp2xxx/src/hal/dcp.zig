//! Double-Co-Pro Support
//!
//! The Double-Co-Pro is a very simple sort-of-FPU. It doesn't execute Arm FPU
//! instructions like the Cortex-M33F's built-in FPU does. But it can perform
//! some basic operations that can greatly speed up a pure-software FPU library.
//! We can:
//!
//! * copy 64-bit values in to the co-pro with an `mrrc` instruction
//! * copy 64-bit values out of the co-pro with an `mcrr` instruction
//! * trigger the co-pro to do a thing with a `cdp` instruction
//!
//! We provide some functions here which can do accelerated FPU operations. The
//! assembly is taken from the rust RP2350 hal.
//!
//! If you set `use_dcp` to true in `HAL_Options`, we will replace the standard
//! `__aeabi_dadd` and `__aeabi_dmul` functions with versions that complete
//! around 3x to 6x faster.

/// Perform a fast add of two f64 values, using the DCP.
pub fn dadd(x: f64, y: f64) f64 {
    return _aapcs_dcp_add(x, y);
}

/// Replace the built-in `__aeabi_dadd` function with one that uses the DCP.
export fn __aeabi_dadd(x: f64, y: f64) callconv(.{ .arm_aapcs_vfp = .{} }) f64 {
    return _aapcs_dcp_add(x, y);
}

/// Perform a fast multiply of two f64 values, using the DCP.
pub fn dmul(x: f64, y: f64) f64 {
    return _aapcs_dcp_mul(x, y);
}

/// Replace the built-in `__aeabi_dmul` function with one that uses the DCP.
export fn __aeabi_dmul(x: f64, y: f64) callconv(.{ .arm_aapcs_vfp = .{} }) f64 {
    return _aapcs_dcp_mul(x, y);
}

extern fn _aapcs_dcp_mul(x: f64, y: f64) callconv(.{ .arm_aapcs_vfp = .{} }) f64;
extern fn _aapcs_dcp_add(x: f64, y: f64) callconv(.{ .arm_aapcs_vfp = .{} }) f64;

comptime {
    asm (
        \\.syntax unified
        \\.cpu cortex-m33
        \\.cfi_sections .debug_frame
        \\.thumb
        \\
        // Do a fast f64 multiply on the DCP.
        //
        // Assumes the DCP has been enabled in the CPACR register.
        //
        // * First f64 is in r0,r1
        // * Second f64 is in r2,r3
        // * Result is in r0,r1
        //
        // This function is Copyright (c) 2024 Raspberry Pi (Trading) Ltd.
        // SPDX-License-Identifier: BSD-3-Clause
        \\
        \\.global _aapcs_dcp_mul
        \\.type _aapcs_dcp_mul,%function
        \\.cfi_startproc
        \\.p2align 2
        \\1:
        \\    push {lr}                     // Save LR
        \\    bl generic_save_state         // Run the save/restore routine
        \\    b 1f                          // Jump forward to run the routine
        \\_aapcs_dcp_mul:
        \\    mrc2 p4,#0,apsr_nzcv,c0,c0,#1 // PCMP apsr_nzcv - If DCP is running, set the Negative flag
        \\    bmi 1b                        // Branch back if minus (i.e. negative flag is set)
        \\1:                                // Usually we fall right through, which is fast
        \\    push {r4,r14}                 // Save the callee-save temp registers we are using
        \\    mcrr p4,#1,r0,r1,c0           // WXUP r0,r1 - write r1|r0 to xm and xe
        \\    mcrr p4,#1,r2,r3,c1           // WYUP r2,r3 - write r3|r2 to ym and ye
        \\    mrrc p4,#0,r0,r1,c4           // RXMS r0,r1,0 - read xm Q62-s
        \\    mrrc p4,#0,r2,r3,c5           // RYMS r2,r3,0 - read xy Q62-s
        \\    umull r4,r12,r0,r2            // Unsigned Long Multiply r12|r4 := r0*r2
        \\    movs r14,#0                   // r14 = 0
        \\    umlal r12,r14,r0,r3           // Unsigned Long Multiply with Accumulate r14|r12 += r0*r3
        \\    umlal r12,r14,r1,r2           // Unsigned Long Multiply with Accumulate r14|r12 += r1*r2
        \\    mcrr p4,#2,r4,r12,c0          // WXMS r4,r12 - set xm bit 0 if r12|r4 is 0, or 1 if r12|r4 is non-zero
        \\    movs r4,#0                    // r4 = 0
        \\    umlal r14,r4,r1,r3            // Unsigned Long Multiply with Accumulate r4|r14 += r1*r3
        \\    mcrr p4,#3,r14,r4,c0          // WXMO r14,r4 - write xm direct OR into b0, add exponents, XOR signs
        \\    cdp p4,#8,c0,c0,c0,#1         // NRDD - normalise and round double-precision
        \\    mrrc p4,#5,r0,r1,c0           // RDDM r0,r1 - read DMUL result packed from xm and xe
        \\    pop {r4,lr}                   // Restore the callee-save temp registers we are using
        \\    bx lr                         // Return to caller
        \\.cfi_endproc
        \\.size _aapcs_dcp_mul, . - _aapcs_dcp_mul
        \\
        // Do a fast f64 add on the DCP.
        //
        // Assumes the DCP has been enabled in the CPACR register.
        //
        // * First f64 is in r0,r1
        // * Second f64 is in r2,r3
        // * Result is in r0,r1
        //
        // This function is Copyright (c) 2024 Raspberry Pi (Trading) Ltd.
        // SPDX-License-Identifier: BSD-3-Clause
        \\
        \\.global _aapcs_dcp_add
        \\.type _aapcs_dcp_add,%function
        \\.cfi_startproc
        \\.p2align 2
        \\1:
        \\    push {lr}                     // Save LR
        \\    bl generic_save_state         // Run the save/restore routine
        \\    b 1f                          // Jump forward to run the routine
        \\_aapcs_dcp_add:
        \\    mrc2 p4,#0,apsr_nzcv,c0,c0,#1 // PCMP apsr_nzcv - If DCP is running, set the Negative flag
        \\    bmi 1b                        // Branch back if minus (i.e. negative flag is set)
        \\1:                                // Usually we fall right through, which is fast
        \\    mcrr p4,#1,r0,r1,c0           // WXUP r0,r1 - write r1|r0 to xm and xe
        \\    mcrr p4,#1,r2,r3,c1           // WYUP r2,r3 - write r3|r2 to ym and ye
        \\    cdp p4,#0,c0,c0,c1,#0         // ADD0 - compare X-Y, set status
        \\    cdp p4,#1,c0,c0,c1,#0         // ADD1 - xm := ±xm+±ym>>s or ±ym+±xm>>s
        \\    cdp p4,#8,c0,c0,c0,#1         // NRDD - normalise and round double-precision
        \\    mrrc p4,#1,r0,r1,c0           // RDDA r0,r1 - read DADD result packed from xm and xe
        \\    bx lr                         // Return to caller (or to state restore routine)
        \\.cfi_endproc
        \\.size _aapcs_dcp_add, . - _aapcs_dcp_add
        \\
        // This code grabs the DCP state and pushes it to the stack.
        // It then does a subroutine call back to where it came from
        // and when that subroutine finishes (the original function we were
        // trying to call), then we return here and restore the DCP state before
        // actually returning to the caller.
        \\
        \\.thumb_func
        \\generic_save_state:
        \\    sub sp, #24
        \\    push {r0, r1}
        \\    // save DCP state here
        \\    mrrc2 p4,#0,r0,r1,c8      // PXMD r0, r1
        \\    strd r0, r1, [sp, #8 + 0]
        \\    mrrc2 p4,#0,r0,r1,c9      // PYMD r0, r1
        \\    strd r0, r1, [sp, #8 + 8]
        \\    mrrc p4,#0,r0,r1,c10      // REFD r0, r1
        \\    strd r0, r1, [sp, #8 + 16]
        \\    pop {r0, r1}
        \\    blx lr // briefly visit the function we're wrapping
        \\    // now restore the DCP state from the stack
        \\    pop {r12, r14}
        \\    mcrr p4,#0,r12,r14,c0     // WXMD r12, r14
        \\    pop {r12, r14}
        \\    mcrr p4,#0,r12,r14,c1     // WYMD r12, r14
        \\    pop {r12, r14}
        \\    mcrr p4,#0,r12,r14,c2     // WEFD r12, r14
        \\    pop {pc}
        \\
    );
}
