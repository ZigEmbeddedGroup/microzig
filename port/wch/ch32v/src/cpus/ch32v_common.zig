const std = @import("std");
const root = @import("root");
const microzig_options = root.microzig_options;
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const riscv32_common = @import("riscv32-common");

const PFIC = peripherals.PFIC;

pub const riscv_calling_convention: std.builtin.CallingConvention = .{ .riscv32_interrupt = .{ .mode = .machine } };

pub const Exception = enum(u32) {
    InstructionMisaligned = 0x0,
    InstructionFault = 0x1,
    IllegalInstruction = 0x2,
    Breakpoint = 0x3,
    LoadMisaligned = 0x4,
    LoadFault = 0x5,
    StoreMisaligned = 0x6,
    StoreFault = 0x7,
    UserEnvCall = 0x8,
    MachineEnvCall = 0xb,
};

pub const InterruptHandler = *const fn () callconv(riscv_calling_convention) void;

pub fn GenerateInterruptFuncs(comptime Interrupt: type) type {
    const type_info = @typeInfo(Interrupt);
    if (type_info != .@"enum")
        @compileError("Interrupt must have a enum type!");

    return struct {
        pub inline fn globally_enabled() bool {
            return csr.mstatus.read().mie == 1;
        }

        pub inline fn enable_interrupts() void {
            csr.mstatus.set(.{ .mie = 1 });
        }

        pub inline fn disable_interrupts() void {
            csr.mstatus.clear(.{ .mie = 1 });
        }

        pub inline fn is_enabled(irq: Interrupt) bool {
            const irq_num = @intFromEnum(irq);
            const num = irq_num >> 5;
            const pos = irq_num & 0x1F;
            const v = switch (num) {
                0 => getBit(PFIC.ISR1, pos),
                1 => getBit(PFIC.ISR2, pos),
                2 => getBit(PFIC.ISR3, pos),
                3 => getBit(PFIC.ISR4, pos),
                else => @compileError("Invalid interrupt number!"),
            };
            return v != 0;
        }

        pub inline fn enable(irq: Interrupt) void {
            comptime {
                const irq_name = @tagName(irq);
                if (@field(root.microzig_options.interrupts, irq_name) == null) {
                    @compileError(
                        irq_name ++ " interrupt handler should be defined.\n" ++
                            "Add to your main file:\n" ++
                            "    pub const microzig_options: microzig.Options = .{\n" ++
                            "        .interrupts = .{\n" ++
                            "            ." ++ irq_name ++ " = your_handler_for_" ++ irq_name ++ ",\n" ++
                            "        },\n" ++
                            "    };\n",
                    );
                }
            }

            const irq_num = @intFromEnum(irq);
            const num = irq_num >> 5;
            const pos = irq_num & 0x1F;
            switch (num) {
                0 => PFIC.IENR1.raw |= @as(u32, 1) << pos,
                1 => PFIC.IENR2.raw |= @as(u32, 1) << pos,
                2 => PFIC.IENR3.raw |= @as(u32, 1) << pos,
                3 => PFIC.IENR4.raw |= @as(u32, 1) << pos,
                else => @compileError("Invalid interrupt number!"),
            }
        }

        pub inline fn disable(irq: Interrupt) void {
            const irq_num = @intFromEnum(irq);
            const num = irq_num >> 5;
            const pos = irq_num & 0x1F;
            switch (num) {
                0 => PFIC.IRER1.raw |= @as(u32, 1) << pos,
                1 => PFIC.IRER2.raw |= @as(u32, 1) << pos,
                2 => PFIC.IRER3.raw |= @as(u32, 1) << pos,
                3 => PFIC.IRER4.raw |= @as(u32, 1) << pos,
                else => @compileError("Invalid interrupt number!"),
            }
        }

        pub inline fn is_pending(irq: Interrupt) bool {
            const irq_num = @intFromEnum(irq);
            const num = irq_num >> 5;
            const pos = irq_num & 0x1F;
            const v = switch (num) {
                0 => getBit(PFIC.IPR1, pos),
                1 => getBit(PFIC.IPR2, pos),
                2 => getBit(PFIC.IPR3, pos),
                3 => getBit(PFIC.IPR4, pos),
                else => @compileError("Invalid interrupt number!"),
            };
            return v != 0;
        }

        pub inline fn set_pending(irq: Interrupt) void {
            const irq_num = @intFromEnum(irq);
            const num = irq_num >> 5;
            const pos = irq_num & 0x1F;
            switch (num) {
                0 => PFIC.IPSR1.raw |= @as(u32, 1) << pos,
                1 => PFIC.IPSR2.raw |= @as(u32, 1) << pos,
                2 => PFIC.IPSR3.raw |= @as(u32, 1) << pos,
                3 => PFIC.IPSR4.raw |= @as(u32, 1) << pos,
                else => @compileError("Invalid interrupt number!"),
            }
        }

        pub inline fn clear_pending(irq: Interrupt) void {
            const irq_num = @intFromEnum(irq);
            const num = irq_num >> 5;
            const pos = irq_num & 0x1F;
            switch (num) {
                0 => PFIC.IPRR1.raw |= @as(u32, 1) << pos,
                1 => PFIC.IPRR2.raw |= @as(u32, 1) << pos,
                2 => PFIC.IPRR3.raw |= @as(u32, 1) << pos,
                3 => PFIC.IPRR4.raw |= @as(u32, 1) << pos,
                else => @compileError("Invalid interrupt number!"),
            }
        }

        pub inline fn is_active(irq: Interrupt) void {
            const irq_num = @intFromEnum(irq);
            const num = irq_num >> 5;
            const pos = irq_num & 0x1F;
            const v = switch (num) {
                0 => getBit(PFIC.IACTR1, pos),
                1 => getBit(PFIC.IACTR2, pos),
                2 => getBit(PFIC.IACTR3, pos),
                3 => getBit(PFIC.IACTR4, pos),
                else => @compileError("Invalid interrupt number!"),
            };
            return v != 0;
        }

        /// Interrupt priority configuration.
        /// priority -
        /// bit7 - pre-emption priority
        /// bit6~bit4 - subpriority
        /// bit3~bit0 - reserved (must be 0)
        pub inline fn set_priority(comptime irq: Interrupt, priority: u8) void {
            const irq_num = @intFromEnum(irq);
            const irq_num_str = std.fmt.comptimePrint("{}", .{irq_num});
            @field(PFIC, "IPRIOR" ++ irq_num_str) = @intFromEnum(priority) & 0b1111_0000;
        }

        pub inline fn get_priority(comptime irq: Interrupt) u8 {
            const irq_num = @intFromEnum(irq);
            const irq_num_str = std.fmt.comptimePrint("{}", .{irq_num});
            return @field(PFIC, "IPRIOR" ++ irq_num_str);
        }

        inline fn getBit(self: anytype, pos: u5) u1 {
            return @truncate(self.raw >> pos);
        }
    };
}

pub inline fn wfi() void {
    PFIC.SCTLR.modify(.{ .WFITOWFE = 0 });
    asm volatile ("wfi");
}

pub inline fn wfe() void {
    PFIC.SCTLR.modify(.{ .WFITOWFE = 1 });
    asm volatile ("wfi");
}

const vector_table_offset = 1; // First entry is reserved for the _reset_vector.

fn vector_table_size(comptime Interrupt: type) usize {
    const type_info = @typeInfo(Interrupt);

    const interrupts_list = type_info.@"enum".fields;
    const last_interrupt = interrupts_list[interrupts_list.len - 1];
    const last_interrupt_idx = last_interrupt.value;

    return last_interrupt_idx + 1 - vector_table_offset;
}

pub fn generate_vector_table(comptime Interrupt: type) [vector_table_size(Interrupt)]InterruptHandler {
    @setEvalBranchQuota(100_000);

    const type_info = @typeInfo(Interrupt);
    const interrupts_list = type_info.@"enum".fields;

    var temp: [vector_table_size(Interrupt)]InterruptHandler = @splat(microzig_options.interrupts.Exception orelse unhandled);
    for (&temp, vector_table_offset..) |_, idx| {
        // Find name of the interrupt by its number.
        var name: ?[:0]const u8 = null;
        for (interrupts_list) |decl| {
            if (decl.value == idx) {
                name = decl.name;
                break;
            }
        }

        if (name) |n| {
            if (@field(microzig_options.interrupts, n)) |h| {
                temp[idx - vector_table_offset] = h;
            }
        }
    }

    return temp;
}

pub fn unhandled() callconv(riscv_calling_convention) void {
    const mcause = csr.mcause.read();

    if (mcause.is_interrupt != 0) {
        std.log.err("unhandled interrupt {} occurred!", .{mcause.code});
    } else {
        std.log.err("exception 0x{x} occurred!", .{mcause.code});
    }

    @panic("unhandled interrupt");
}

pub inline fn initialize_system_memories() void {
    // Clear .bss section.
    asm volatile (
        \\    li a0, 0
        \\    la a1, microzig_bss_start
        \\    la a2, microzig_bss_end
        \\    beq a1, a2, clear_bss_done
        \\clear_bss_loop:
        \\    sw a0, 0(a1)
        \\    addi a1, a1, 4
        \\    blt a1, a2, clear_bss_loop
        \\clear_bss_done:
    );

    // Copy .data from FLASH to RAM.
    asm volatile (
        \\    la a0, microzig_data_load_start
        \\    la a1, microzig_data_start
        \\    la a2, microzig_data_end
        \\copy_data_loop:
        \\    beq a1, a2, copy_done
        \\    lw a3, 0(a0)
        \\    sw a3, 0(a1)
        \\    addi a0, a0, 4
        \\    addi a1, a1, 4
        \\    bne a1, a2, copy_data_loop
        \\copy_done:
    );
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
        hwstkoven: u1 = 0,
        /// [5] Global interrupt and HPE off enable
        gihwstknen: u1 = 0,
        /// [7:6] Reserved
        reserved1: u2 = 0,
        /// [15:8] Preemption status indication
        pmtsta: u8 = 0,
        /// [31:16] Reserved
        reserved0: u16 = 0,
    });
    pub const corecfgr = Csr(0xBC0, u32);
    pub const cstrcr = Csr(0xBC2, u32);
    pub const cpmpocr = Csr(0xBC3, u32);
    pub const cmcr = Csr(0xBD0, u32);
    pub const cinfor = Csr(0xFC0, u32);
};
