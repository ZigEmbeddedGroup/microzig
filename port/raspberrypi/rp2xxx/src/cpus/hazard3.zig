const std = @import("std");
const microzig = @import("microzig");
const riscv32_common = @import("riscv32-common");

pub const CPU_Options = struct {
    ram_vectors: bool = true,
    has_ram_vectors_section: bool = false,
};

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

pub const CoreInterrupt = enum(u5) {
    MachineSoftware = 0x3,
    MachineTimer = 0x7,
    MachineExternal = 0xb,
};

// supports a maximum of 128 interrupts (actually supports 512 but for some reason priorities
// only support 128)
pub const ExternalInterrupt = microzig.utilities.GenerateInterruptEnum(u7);

// NOTE: there is no way to use a custom incoming_stack_alignment with this way of doing things
const riscv_calling_convention: std.builtin.CallingConvention = .{ .riscv32_interrupt = .{ .mode = .machine } };

pub const InterruptHandler = extern union {
    naked: *const fn () callconv(.naked) noreturn,
    riscv: *const fn () callconv(riscv_calling_convention) void,
};

pub const Handler = microzig.interrupt.Handler;

pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = enum { Exception }, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = CoreInterrupt, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = ExternalInterrupt, .HandlerFn = Handler },
});

pub const interrupt = struct {
    pub const globally_enabled = riscv32_common.interrupt.globally_enabled;
    pub const enable_interrupts = riscv32_common.interrupt.enable_interrupts;
    pub const disable_interrupts = riscv32_common.interrupt.disable_interrupts;

    // use a custom `CoreInterrupt` enum specifically for hazard3
    pub const core = riscv32_common.utilities.interrupt.CoreImpl(CoreInterrupt);

    pub fn is_enabled(int: ExternalInterrupt) bool {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        return csr.meiea.read_set(.{ .index = index }).window & mask != 0;
    }

    pub fn enable(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.meiea.set(.{
            .index = index,
            .window = mask,
        });
    }

    pub fn disable(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.meiea.clear(.{
            .index = index,
            .window = mask,
        });
    }

    pub fn is_pending(int: ExternalInterrupt) bool {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        return csr.meipa.read_set(.{ .index = index }).window & mask != 0;
    }

    pub fn set_pending(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.meifa.set(.{ .index = index, .window = mask });
    }

    pub fn clear_pending(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.meifa.clear(.{ .index = index, .window = mask });
    }

    pub const Priority = enum(u4) {
        lowest = 0,
        highest = 15,
        _,
    };

    pub fn set_priority(int: ExternalInterrupt, priority: Priority) void {
        const num: u7 = @intFromEnum(int);
        const index: u5 = @intCast(num >> 2);
        const shift: u4 = @intCast(4 * (num & 0x4));
        const set_mask: u16 = @as(u16, @intFromEnum(priority)) << shift;
        const clear_mask: u16 = @as(u16, 0xf) << shift;
        csr.meipra.clear(.{ .index = index, .window = clear_mask });
        csr.meipra.set(.{ .index = index, .window = set_mask });
    }

    pub fn get_priority(int: ExternalInterrupt) Priority {
        const num: u7 = @intFromEnum(int);
        const index: u5 = @intCast(num >> 2);
        const shift: u4 = @intCast(4 * (num & 0x4));
        const mask: u16 = @as(u16, 0xf) << shift;
        return @enumFromInt((csr.meipra.read_set(.{ .index = index }).window & mask) >> shift);
    }

    pub inline fn has_ram_vectors() bool {
        return @hasField(@TypeOf(microzig.options.cpu), "ram_vectors") and microzig.options.cpu.ram_vectors;
    }

    pub inline fn has_ram_vectors_section() bool {
        return @hasField(@TypeOf(microzig.options.cpu), "has_ram_vectors_section") and microzig.options.cpu.has_ram_vectors_section;
    }

    pub fn set_handler(int: ExternalInterrupt, handler: ?Handler) ?Handler {
        if (!has_ram_vectors()) {
            @compileError("RAM vectors are disabled. Consider adding .platform = .{ .ram_vectors = true } to your microzig_options");
        }

        const old_handler = ram_vectors[@intFromEnum(int)];
        ram_vectors[@intFromEnum(int)] = handler orelse microzig.interrupt.unhandled;
        return if (old_handler.naked == microzig.interrupt.unhandled.naked) null else old_handler;
    }
};

pub const nop = riscv32_common.nop;
pub const wfi = riscv32_common.wfi;

pub fn wfe() void {
    // MAGIC: This instruction which seems to accomplishes nothing, is actually
    //        a hint instruction that blocks the current core.
    asm volatile ("slt zero, zero, x0");
}

pub fn sev() void {
    // MAGIC: This instruction which seems to accomplishes nothing, is actually
    //        a hint instruction that unblocks the other core.
    asm volatile ("slt zero, zero, x1");
}

const vector_count = @sizeOf(microzig.chip.VectorTable) / @sizeOf(usize);

var ram_vectors: [vector_count]Handler = undefined;

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub export fn _start() linksection(if (microzig.config.ram_image)
        "microzig_ram_start"
    else
        "microzig_flash_start") callconv(.naked) noreturn {
        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );

        asm volatile ("mv sp, %[eos]"
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );

        asm volatile (
            \\la a0, _vector_table
            \\or a0, a0, 1
            \\csrw mtvec, a0
            \\
            \\csrr a0, mhartid // if core 1 gets here (through a miracle), send it back to bootrom
            \\bnez a0, reenter_bootrom
            \\
            \\j _start_c
            \\
            \\reenter_bootrom:
            \\li a0, 0x7dfc
            \\jr a0
        );
    }

    pub export fn _start_c() callconv(.c) noreturn {
        if (!microzig.config.ram_image) {
            microzig.utilities.initialize_system_memories();
        }

        // Move vector table to RAM if requested
        if (interrupt.has_ram_vectors()) {
            if (interrupt.has_ram_vectors_section()) {
                @export(&ram_vectors, .{
                    .name = "_ram_vectors",
                    .section = "ram_vectors",
                    .linkage = .strong,
                });
            } else {
                @export(&ram_vectors, .{
                    .name = "_ram_vectors",
                    .linkage = .strong,
                });
            }

            @memcpy(&ram_vectors, &startup_logic.external_interrupt_table);
        }

        microzig_main();
    }

    fn unhandled_interrupt() callconv(riscv_calling_convention) void {
        @panic("unhandled core interrupt");
    }

    pub export fn _vector_table() align(64) linksection("core_vectors") callconv(.naked) noreturn {
        comptime {
            // NOTE: using the union variant .naked here is fine because both variants have the same layout
            @export(if (microzig.options.interrupts.Exception) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_exception_handler" });
            @export(if (microzig.options.interrupts.MachineSoftware) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_machine_software_handler" });
            @export(if (microzig.options.interrupts.MachineTimer) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_machine_timer_handler" });
            @export(if (microzig.options.interrupts.MachineExternal) |handler| handler.naked else &machine_external_interrupt, .{ .name = "_machine_external_handler" });
        }

        asm volatile (
            \\j _exception_handler
            \\.word 0
            \\.word 0
            \\j _machine_software_handler
            \\.word 0
            \\.word 0
            \\.word 0
            \\j _machine_timer_handler
            \\.word 0
            \\.word 0
            \\.word 0
            \\j _machine_external_handler
        );
    }

    const external_interrupt_table = blk: {
        var temp: [vector_count]Handler = @splat(microzig.interrupt.unhandled);

        for (@typeInfo(ExternalInterrupt).@"enum".fields) |field| {
            if (@field(microzig.options.interrupts, field.name)) |handler| {
                temp[field.value] = handler;
            }
        }

        break :blk temp;
    };

    pub export fn machine_external_interrupt() callconv(riscv_calling_convention) void {
        if (microzig.hal.compatibility.arch == .riscv) {
            // MAGIC: This is to work around a bug in the compiler.
            //        If it is not here the compiler fails to generate
            //        the code that saves and restores the registers.

            var x: i32 = 0;
            x += 1;
        }

        if (interrupt.has_ram_vectors()) {
            asm volatile (
                \\csrrsi a0, 0xbe4, 1
                \\bltz a0, no_more_irqs
                \\
                \\dispatch_irq:
                \\lui a1, %hi(_ram_vectors)
                \\add a1, a1, a0
                \\lw a1, %lo(_ram_vectors)(a1)
                \\jalr ra, a1
                \\
                \\get_next_irq:
                \\csrr a0, 0xbe4
                \\bgez a0, dispatch_irq
                \\
                \\no_more_irqs:
            );
        } else {
            asm volatile (
                \\csrrsi a0, 0xbe4, 1
                \\bltz a0, no_more_irqs
                \\
                \\dispatch_irq:
                \\lui a1, %hi(_external_interrupt_table)
                \\add a1, a1, a0
                \\lw a1, %lo(_external_interrupt_table)(a1)
                \\jalr ra, a1
                \\
                \\get_next_irq:
                \\csrr a0, 0xbe4
                \\bgez a0, dispatch_irq
                \\
                \\no_more_irqs:
            );
        }
    }
};

pub fn export_startup_logic() void {
    std.testing.refAllDecls(startup_logic);

    @export(&startup_logic.external_interrupt_table, .{
        .name = "_external_interrupt_table",
        .section = if (!microzig.config.ram_image) "flash_vectors" else null,
        .linkage = .strong,
    });
}

pub const csr = struct {
    pub const cycle = riscv32_common.csr.cycle;
    pub const instret = riscv32_common.csr.instret;

    pub const cycleh = riscv32_common.csr.cycleh;
    pub const instreth = riscv32_common.csr.instreth;

    pub const mvendorid = riscv32_common.csr.mvendorid;
    pub const marchid = riscv32_common.csr.marchid;
    pub const mimpid = riscv32_common.csr.mimpid;
    pub const mhartid = riscv32_common.csr.mhartid;
    pub const mconfigptr = riscv32_common.csr.mconfigptr;

    pub const mstatus = riscv32_common.csr.mstatus;
    pub const misa = riscv32_common.csr.misa;
    pub const medeleg = riscv32_common.csr.medeleg;
    pub const mideleg = riscv32_common.csr.mideleg;
    pub const mie = riscv32_common.csr.mie;
    pub const mtvec = riscv32_common.csr.mtvec;
    pub const mcounteren = riscv32_common.csr.mcounteren;
    pub const mstatush = riscv32_common.csr.mstatush;

    pub const mscratch = riscv32_common.csr.mscratch;
    pub const mepc = riscv32_common.csr.mepc;
    pub const mcause = riscv32_common.csr.mcause;
    pub const mtval = riscv32_common.csr.mtval;
    pub const mip = riscv32_common.csr.mip;

    pub const menvcfg = riscv32_common.csr.menvcfg;
    pub const menvcfgh = riscv32_common.csr.menvcfgh;

    pub const pmpcfg0 = riscv32_common.csr.pmpcfg0;
    pub const pmpcfg1 = riscv32_common.csr.pmpcfg1;
    pub const pmpcfg2 = riscv32_common.csr.pmpcfg2;
    pub const pmpcfg3 = riscv32_common.csr.pmpcfg3;

    pub const pmpaddr0 = riscv32_common.csr.pmpaddr0;
    pub const pmpaddr1 = riscv32_common.csr.pmpaddr1;
    pub const pmpaddr2 = riscv32_common.csr.pmpaddr2;
    pub const pmpaddr3 = riscv32_common.csr.pmpaddr3;
    pub const pmpaddr4 = riscv32_common.csr.pmpaddr4;
    pub const pmpaddr5 = riscv32_common.csr.pmpaddr5;
    pub const pmpaddr6 = riscv32_common.csr.pmpaddr6;
    pub const pmpaddr7 = riscv32_common.csr.pmpaddr7;
    pub const pmpaddr8 = riscv32_common.csr.pmpaddr8;
    pub const pmpaddr9 = riscv32_common.csr.pmpaddr9;
    pub const pmpaddr10 = riscv32_common.csr.pmpaddr10;
    pub const pmpaddr11 = riscv32_common.csr.pmpaddr11;
    pub const pmpaddr12 = riscv32_common.csr.pmpaddr12;
    pub const pmpaddr13 = riscv32_common.csr.pmpaddr13;
    pub const pmpaddr14 = riscv32_common.csr.pmpaddr14;
    pub const pmpaddr15 = riscv32_common.csr.pmpaddr15;

    pub const mcycle = riscv32_common.csr.mcycle;
    pub const minstret = riscv32_common.csr.minstret;
    pub const mhpmcounter3 = riscv32_common.csr.mhpmcounter3;
    pub const mhpmcounter4 = riscv32_common.csr.mhpmcounter4;
    pub const mhpmcounter5 = riscv32_common.csr.mhpmcounter5;
    pub const mhpmcounter6 = riscv32_common.csr.mhpmcounter6;
    pub const mhpmcounter7 = riscv32_common.csr.mhpmcounter7;
    pub const mhpmcounter8 = riscv32_common.csr.mhpmcounter8;
    pub const mhpmcounter9 = riscv32_common.csr.mhpmcounter9;
    pub const mhpmcounter10 = riscv32_common.csr.mhpmcounter10;
    pub const mhpmcounter11 = riscv32_common.csr.mhpmcounter11;
    pub const mhpmcounter12 = riscv32_common.csr.mhpmcounter12;
    pub const mhpmcounter13 = riscv32_common.csr.mhpmcounter13;
    pub const mhpmcounter14 = riscv32_common.csr.mhpmcounter14;
    pub const mhpmcounter15 = riscv32_common.csr.mhpmcounter15;
    pub const mhpmcounter16 = riscv32_common.csr.mhpmcounter16;
    pub const mhpmcounter17 = riscv32_common.csr.mhpmcounter17;
    pub const mhpmcounter18 = riscv32_common.csr.mhpmcounter18;
    pub const mhpmcounter19 = riscv32_common.csr.mhpmcounter19;
    pub const mhpmcounter20 = riscv32_common.csr.mhpmcounter20;
    pub const mhpmcounter21 = riscv32_common.csr.mhpmcounter21;
    pub const mhpmcounter22 = riscv32_common.csr.mhpmcounter22;
    pub const mhpmcounter23 = riscv32_common.csr.mhpmcounter23;
    pub const mhpmcounter24 = riscv32_common.csr.mhpmcounter24;
    pub const mhpmcounter25 = riscv32_common.csr.mhpmcounter25;
    pub const mhpmcounter26 = riscv32_common.csr.mhpmcounter26;
    pub const mhpmcounter27 = riscv32_common.csr.mhpmcounter27;
    pub const mhpmcounter28 = riscv32_common.csr.mhpmcounter28;
    pub const mhpmcounter29 = riscv32_common.csr.mhpmcounter29;
    pub const mhpmcounter30 = riscv32_common.csr.mhpmcounter30;
    pub const mhpmcounter31 = riscv32_common.csr.mhpmcounter31;

    pub const mcycleh = riscv32_common.csr.mcycleh;
    pub const minstreth = riscv32_common.csr.minstreth;
    pub const mhpmcounter3h = riscv32_common.csr.mhpmcounter3h;
    pub const mhpmcounter4h = riscv32_common.csr.mhpmcounter4h;
    pub const mhpmcounter5h = riscv32_common.csr.mhpmcounter5h;
    pub const mhpmcounter6h = riscv32_common.csr.mhpmcounter6h;
    pub const mhpmcounter7h = riscv32_common.csr.mhpmcounter7h;
    pub const mhpmcounter8h = riscv32_common.csr.mhpmcounter8h;
    pub const mhpmcounter9h = riscv32_common.csr.mhpmcounter9h;
    pub const mhpmcounter10h = riscv32_common.csr.mhpmcounter10h;
    pub const mhpmcounter11h = riscv32_common.csr.mhpmcounter11h;
    pub const mhpmcounter12h = riscv32_common.csr.mhpmcounter12h;
    pub const mhpmcounter13h = riscv32_common.csr.mhpmcounter13h;
    pub const mhpmcounter14h = riscv32_common.csr.mhpmcounter14h;
    pub const mhpmcounter15h = riscv32_common.csr.mhpmcounter15h;
    pub const mhpmcounter16h = riscv32_common.csr.mhpmcounter16h;
    pub const mhpmcounter17h = riscv32_common.csr.mhpmcounter17h;
    pub const mhpmcounter18h = riscv32_common.csr.mhpmcounter18h;
    pub const mhpmcounter19h = riscv32_common.csr.mhpmcounter19h;
    pub const mhpmcounter20h = riscv32_common.csr.mhpmcounter20h;
    pub const mhpmcounter21h = riscv32_common.csr.mhpmcounter21h;
    pub const mhpmcounter22h = riscv32_common.csr.mhpmcounter22h;
    pub const mhpmcounter23h = riscv32_common.csr.mhpmcounter23h;
    pub const mhpmcounter24h = riscv32_common.csr.mhpmcounter24h;
    pub const mhpmcounter25h = riscv32_common.csr.mhpmcounter25h;
    pub const mhpmcounter26h = riscv32_common.csr.mhpmcounter26h;
    pub const mhpmcounter27h = riscv32_common.csr.mhpmcounter27h;
    pub const mhpmcounter28h = riscv32_common.csr.mhpmcounter28h;
    pub const mhpmcounter29h = riscv32_common.csr.mhpmcounter29h;
    pub const mhpmcounter30h = riscv32_common.csr.mhpmcounter30h;
    pub const mhpmcounter31h = riscv32_common.csr.mhpmcounter31h;

    pub const mcountinhibit = riscv32_common.csr.mcountinhibit;
    pub const mhpmevent3 = riscv32_common.csr.mhpmevent3;
    pub const mhpmevent4 = riscv32_common.csr.mhpmevent4;
    pub const mhpmevent5 = riscv32_common.csr.mhpmevent5;
    pub const mhpmevent6 = riscv32_common.csr.mhpmevent6;
    pub const mhpmevent7 = riscv32_common.csr.mhpmevent7;
    pub const mhpmevent8 = riscv32_common.csr.mhpmevent8;
    pub const mhpmevent9 = riscv32_common.csr.mhpmevent9;
    pub const mhpmevent10 = riscv32_common.csr.mhpmevent10;
    pub const mhpmevent11 = riscv32_common.csr.mhpmevent11;
    pub const mhpmevent12 = riscv32_common.csr.mhpmevent12;
    pub const mhpmevent13 = riscv32_common.csr.mhpmevent13;
    pub const mhpmevent14 = riscv32_common.csr.mhpmevent14;
    pub const mhpmevent15 = riscv32_common.csr.mhpmevent15;
    pub const mhpmevent16 = riscv32_common.csr.mhpmevent16;
    pub const mhpmevent17 = riscv32_common.csr.mhpmevent17;
    pub const mhpmevent18 = riscv32_common.csr.mhpmevent18;
    pub const mhpmevent19 = riscv32_common.csr.mhpmevent19;
    pub const mhpmevent20 = riscv32_common.csr.mhpmevent20;
    pub const mhpmevent21 = riscv32_common.csr.mhpmevent21;
    pub const mhpmevent22 = riscv32_common.csr.mhpmevent22;
    pub const mhpmevent23 = riscv32_common.csr.mhpmevent23;
    pub const mhpmevent24 = riscv32_common.csr.mhpmevent24;
    pub const mhpmevent25 = riscv32_common.csr.mhpmevent25;
    pub const mhpmevent26 = riscv32_common.csr.mhpmevent26;
    pub const mhpmevent27 = riscv32_common.csr.mhpmevent27;
    pub const mhpmevent28 = riscv32_common.csr.mhpmevent28;
    pub const mhpmevent29 = riscv32_common.csr.mhpmevent29;
    pub const mhpmevent30 = riscv32_common.csr.mhpmevent30;
    pub const mhpmevent31 = riscv32_common.csr.mhpmevent31;

    pub const tselect = riscv32_common.csr.tselect;
    pub const tdata1 = riscv32_common.csr.tdata1;
    pub const tdata2 = riscv32_common.csr.tdata2;

    pub const dcsr = riscv32_common.csr.dcsr;
    pub const dpc = riscv32_common.csr.dpc;

    pub const meiea = Csr(0xbe0, packed struct {
        index: u5,
        reserved0: u11,
        window: u16,
    });
    pub const meipa = Csr(0xbe1, packed struct {
        index: u5,
        reserved0: u11,
        window: u16,
    });
    pub const meifa = Csr(0xbe2, packed struct {
        index: u5,
        reserved0: u11,
        window: u16,
    });
    pub const meipra = Csr(0xbe3, packed struct {
        index: u5,
        reserved0: u11,
        window: u16,
    });
    pub const meinext = Csr(0xbe4, packed struct {
        update: u1,
        reserved0: u1,
        irq: u9,
        reserved1: u20,
        noirq: u1,
    });
    pub const meicontext = Csr(0xbe5, u32);

    pub const pmpcfgm0 = Csr(0xbd0, u32);

    pub const msleep = Csr(0xbf0, u32);

    pub const Csr = riscv32_common.csr.Csr;
};
