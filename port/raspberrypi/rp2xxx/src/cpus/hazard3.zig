const std = @import("std");
const root = @import("root");
const microzig_options = root.microzig_options;
const microzig = @import("microzig");
const riscv32_common = @import("riscv32-common");

pub const CPUOptions = struct {
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

pub const CoreInterrupt = enum(u32) {
    MachineSoftware = 0x3,
    MachineTimer = 0x7,
    MachineExternal = 0xb,
};

// supports a maximum of 128 interrupts (xh3irq actually supports 512 but for some reason priorities
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
        return csr.xh3irq.meiea.read_set(.{ .index = index }).window & mask != 0;
    }

    pub fn enable(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.xh3irq.meiea.set(.{
            .index = index,
            .window = mask,
        });
    }

    pub fn disable(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.xh3irq.meiea.clear(.{
            .index = index,
            .window = mask,
        });
    }

    pub fn is_pending(int: ExternalInterrupt) bool {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        return csr.xh3irq.meipa.read_set(.{ .index = index }).window & mask != 0;
    }

    pub fn set_pending(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.xh3irq.meifa.set(.{ .index = index, .window = mask });
    }

    pub fn clear_pending(int: ExternalInterrupt) void {
        const num: u7 = @intFromEnum(int);
        const index: u3 = @intCast(num >> 4);
        const mask: u16 = @as(u16, 1) << @as(u4, @intCast(num & 0xf));
        csr.xh3irq.meifa.clear(.{ .index = index, .window = mask });
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
        const clear_mask: u16 = 0xf << shift;
        csr.xh3irq.meifa.clear(.{ .index = index, .window = clear_mask });
        csr.xh3irq.meifa.set(.{ .index = index, .window = set_mask });
    }

    pub fn get_priority(int: ExternalInterrupt) Priority {
        const num: u7 = @intFromEnum(int);
        const index: u5 = @intCast(num >> 2);
        const shift: u4 = @intCast(4 * (num & 0x4));
        const mask: u16 = @as(u16, 0xf) << shift;
        return @enumFromInt((csr.xh3irq.meifa.read_set(.{ .index = index }).window & mask) >> shift);
    }

    pub inline fn has_ram_vectors() bool {
        return @hasField(@TypeOf(microzig_options.cpu), "ram_vectors") and microzig_options.cpu.ram_vectors;
    }

    pub inline fn has_ram_vectors_section() bool {
        return @hasField(@TypeOf(microzig_options.cpu), "has_ram_vectors_section") and microzig_options.cpu.has_ram_vectors_section;
    }

    pub fn set_handler(comptime int: ExternalInterrupt, handler: ?Handler) ?Handler {
        if (!has_ram_vectors()) {
            @compileError("RAM vectors are disabled. Consider adding .platform = .{ .ram_vectors = true } to your microzig_options");
        }

        const old_handler = ram_vectors[@intFromEnum(int)];
        ram_vectors[@intFromEnum(int)] = handler orelse microzig.interrupt.unhandled;
        return if (old_handler.c == microzig.interrupt.unhandled.c) null else old_handler;
    }
};

pub const wfe = riscv32_common.wfe;
pub const wfi = riscv32_common.wfi;
pub const sev = riscv32_common.sev;
pub const nop = riscv32_common.nop;

const vector_count = @sizeOf(microzig.chip.VectorTable) / @sizeOf(usize);

var ram_vectors: [vector_count]Handler = undefined;

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub export fn _start() linksection("microzig_flash_start") callconv(.naked) noreturn {
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
        root.initialize_system_memories();

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

        interrupt.core.enable(.MachineExternal);

        microzig_main();
    }

    fn unhandled_interrupt() callconv(riscv_calling_convention) void {
        @panic("unhandled core interrupt");
    }

    pub export fn _vector_table() align(64) linksection("core_vectors") callconv(.naked) noreturn {
        comptime {
            // NOTE: using the union variant .naked here is fine because both variants have the same layout
            @export(if (microzig_options.interrupts.Exception) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_exception_handler" });
            @export(if (microzig_options.interrupts.MachineSoftware) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_machine_software_handler" });
            @export(if (microzig_options.interrupts.MachineTimer) |handler| handler.naked else &unhandled_interrupt, .{ .name = "_machine_timer_handler" });
            @export(if (microzig_options.interrupts.MachineExternal) |handler| handler.naked else &machine_external_interrupt, .{ .name = "_machine_external_handler" });
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
            if (@field(microzig_options.interrupts, field.name)) |handler| {
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
        .section = "flash_vectors",
        .linkage = .strong,
    });
}

pub const csr = struct {
    pub const core = riscv32_common.csr.core;

    pub const xh3irq = struct {
        pub const meiea = CSR(0xbe0, packed struct {
            index: u5,
            reserved0: u11,
            window: u16,
        });
        pub const meipa = CSR(0xbe1, packed struct {
            index: u5,
            reserved0: u11,
            window: u16,
        });
        pub const meifa = CSR(0xbe2, packed struct {
            index: u5,
            reserved0: u11,
            window: u16,
        });
        pub const meipra = CSR(0xbe3, packed struct {
            index: u5,
            reserved0: u11,
            window: u16,
        });
        pub const meinext = CSR(0xbe4, packed struct {
            update: u1,
            reserved0: u1,
            irq: u9,
            reserved1: u20,
            noirq: u1,
        });
    };

    pub const CSR = riscv32_common.csr.CSR;
};
