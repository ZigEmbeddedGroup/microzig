const microzig = @import("microzig");
const root = @import("root");

const riscv32_common = @import("riscv32-common");

pub const interrupt = struct {
    pub inline fn enable_interrupts() void {
        asm volatile ("csrsi mstatus, 0b1000");
    }

    pub inline fn disable_interrupts() void {
        asm volatile ("csrci mstatus, 0b1000");
    }
};

pub inline fn wfi() void {
    asm volatile ("wfi");
}

pub inline fn wfe() void {
    const PFIC = microzig.chip.peripherals.PFIC;
    // Treats the subsequent wfi instruction as wfe
    PFIC.SCTLR.modify(.{ .WFITOWFE = 1 });
    asm volatile ("wfi");
}

pub const csr = struct {
    pub const Csr = riscv32_common.csr.Csr;

    /// Architecture Number Register
    /// Examples:
    /// - 0xDC68D841 - WCH-V2A
    /// - 0xDC68D886 - WCH-V4F
    pub const marchid = riscv32_common.csr.marchid;
    pub const mimpid = riscv32_common.csr.mimpid;

    /// Machine Mode Status Register
    pub const mstatus = Csr(0x300, packed struct(u32) {
        pub const Fs = enum(u2) {
            /// Floating-point unit status
            off = 0b00,
            initial = 0b01,
            clean = 0b10,
            dirty = 0b11,
        };

        /// [2:0] Reserved
        reserved4: u3 = 0,
        /// [3] Machine mode interrupt enable
        mie: u1,
        /// [6:4] Reserved
        reserved3: u3 = 0,
        /// [7] Interrupt enable state before entering interrupt
        mpie: u1,
        /// [10:8] Reserved
        reserved2: u3 = 0,
        /// [12:11] Privileged mode before entering break
        mpp: u2 = 0,
        /// [14:13] Reserved
        reserved1: u2 = 0,
        /// [14:13] Floating-point unit status
        /// Valid only for WCH-V4F
        fs: Fs = .off,
        /// [31:15] Reserved
        reserved0: u15 = 0,
    });
    pub const misa = riscv32_common.csr.misa;
    /// Machine Mode Exception Base Address Register
    pub const mtvec = Csr(0x305, packed struct(u32) {
        /// [0] Mode 0
        /// Interrupt or exception entry address mode selection.
        /// 0: Use of the uniform entry address.
        /// 1: Address offset based on interrupt number *4.
        mode0: u1,
        /// [1] Mode 1
        /// Interrupt vector table identifies patterns.
        /// 0: Identification by jump instruction,
        /// limited range, support for non-jump 0 instructions.
        /// 1: Identify by absolute address, support
        /// full range, but must jump.
        mode1: u1,
        /// [31:2] Base address of the interrupt vector table
        base: u30,
    });

    pub const mscratch = riscv32_common.csr.mscratch;
    pub const mepc = riscv32_common.csr.mepc;
    pub const mcause = riscv32_common.csr.mcause;
    pub const mtval = riscv32_common.csr.mtval;

    pub const pmpcfg0 = riscv32_common.csr.pmpcfg0;
    pub const pmpaddr0 = riscv32_common.csr.pmpaddr0;
    pub const pmpaddr1 = riscv32_common.csr.pmpaddr1;
    pub const pmpaddr2 = riscv32_common.csr.pmpaddr2;
    pub const pmpaddr3 = riscv32_common.csr.pmpaddr3;

    pub const fcsr = riscv32_common.csr.fcsr;
    pub const fflags = riscv32_common.csr.fflags;
    pub const frm = riscv32_common.csr.frm;

    pub const dcsr = riscv32_common.csr.dcsr;
    pub const dpc = riscv32_common.csr.dpc;
    pub const dscratch0 = riscv32_common.csr.dscratch0;
    pub const dscratch1 = riscv32_common.csr.dscratch1;

    pub const gintenr = Csr(0x800, u32);
    pub const intsyscr_v2 = Csr(0x804, packed struct(u32) {
        /// [0] HPE enable
        hwstken: u1,
        /// [1] Interrupt nesting enable
        inesten: u1,
        /// [2] EABI enable
        eabien: u1,
        /// [31:3] Reserved
        reserved0: u29 = 0,
    });
    pub const intsyscr_v3 = Csr(0x804, packed struct(u32) {
        /// [0] Hardware stack enable
        hwstken: u1,
        /// [1] Interrupt nesting enable
        inesten: u1,
        /// [3:2] Priority preemption configuration
        pmtcfg: u2,
        /// [4] Reserved
        reserved0: u1 = 0,
        /// [5] Global interrupt and hardware stack shutdown enable
        gihwstknen: u1,
        /// [30:6] Reserved
        reserved1: u25 = 0x380,
        /// [31] Lock
        lock: u1,
    });
    pub const intsyscr_v4 = Csr(0x804, packed struct(u32) {
        /// [0] HPE enable
        hwstken: u1,
        /// [1] Interrupt nesting enable
        inesten: u1,
        /// [3:2] Interrupt nesting depth configuration
        pmtcfg: u2,
        /// [4] Interrupt enable after HPE overflow
        hwstkoven: u1,
        /// [5] Global interrupt and HPE off enable
        gihwstknen: u1,
        /// [7:6] Reserved
        reserved1: u2 = 0,
        /// [15:8] Preemption status indication
        pmtsta: u8,
        /// [31:16] Reserved
        reserved0: u16 = 0,
    });
    pub const corecfgr = Csr(0xBC0, u32);
    pub const cstrcr = Csr(0xBC2, u32);
    pub const cpmpocr = Csr(0xBC3, u32);
    pub const cmcr = Csr(0xBD0, u32);
    pub const cinfor = Csr(0xFC0, u32);
};
