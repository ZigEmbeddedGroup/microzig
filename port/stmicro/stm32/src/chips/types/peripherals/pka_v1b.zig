const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Public key accelerator.
pub const PKA = extern struct {
    /// PKA control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// PKA enable. When an illegal operation is selected while EN=1 OPERRF bit is set in PKA_SR. See PKA_CR.MODE bitfield for details. When EN=0 PKA RAM can still be accessed by the application.
        EN: u1,
        /// start the operation Writing 1 to this bit starts the operation which is selected by MODE[5:0], using the operands and data already written to the PKA RAM. This bit is always read as 0. When an illegal operation is selected while START bit is set no operation is started, and OPERRF bit is set in PKA_SR. START is ignored if PKA is busy.
        START: u1,
        reserved8: u6 = 0,
        /// PKA operation code When an operation not listed here is written by the application with EN bit set, OPERRF bit is set in PKA_SR register, and the write to MODE bitfield is ignored. When PKA is configured in limited mode (LMF = 1 in PKA_SR), writing a MODE different from 0x26 with EN bit to 1 triggers OPERRF bit to be set and write to MODE bit is ignored.
        MODE: u6,
        reserved17: u3 = 0,
        /// End of operation interrupt enable.
        PROCENDIE: u1,
        reserved19: u1 = 0,
        /// RAM error interrupt enable.
        RAMERRIE: u1,
        /// Address error interrupt enable.
        ADDRERRIE: u1,
        /// Operation error interrupt enable.
        OPERRIE: u1,
        padding: u10 = 0,
    }),
    /// PKA status register.
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// PKA initialization OK This bit is asserted when PKA initialization is complete. When RNG is not able to output proper random numbers INITOK stays at 0.
        INITOK: u1,
        reserved16: u15 = 0,
        /// PKA operation is in progress This bit is set to 1 whenever START bit in the PKA_CR is set. It is automatically cleared when the computation is complete, meaning that PKA RAM can be safely accessed and a new operation can be started. If PKA is started with a wrong opcode, it is busy for a couple of cycles, then it aborts automatically the operation and go back to ready (BUSY bit is set to 0).
        BUSY: u1,
        /// PKA End of Operation flag.
        PROCENDF: u1,
        reserved19: u1 = 0,
        /// PKA RAM error flag This bit is cleared using RAMERRFC bit in PKA_CLRFR.
        RAMERRF: u1,
        /// Address error flag This bit is cleared using ADDRERRFC bit in PKA_CLRFR.
        ADDRERRF: u1,
        /// Operation error flag This bit is cleared using OPERRFC bit in PKA_CLRFR.
        OPERRF: u1,
        padding: u10 = 0,
    }),
    /// PKA clear flag register.
    /// offset: 0x08
    CLRFR: mmio.Mmio(packed struct(u32) {
        reserved17: u17 = 0,
        /// Clear PKA End of Operation flag.
        PROCENDFC: u1,
        reserved19: u1 = 0,
        /// Clear PKA RAM error flag.
        RAMERRFC: u1,
        /// Clear address error flag.
        ADDRERRFC: u1,
        /// Clear operation error flag.
        OPERRFC: u1,
        padding: u10 = 0,
    }),
    /// offset: 0x0c
    reserved12: [1012]u8,
    /// PKA internal memeory.
    /// offset: 0x400
    RAM: [1334]u32,
};
