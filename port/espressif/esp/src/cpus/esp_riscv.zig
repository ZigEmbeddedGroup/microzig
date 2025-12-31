const std = @import("std");
const microzig = @import("microzig");

const cpu_config = @import("cpu-config");
const riscv32_common = @import("riscv32-common");

pub const CPU_Options = struct {
    /// If null, interrupts will use same stack. Otherwise, the interrupt
    /// handler will switch to a custom stack after pushing the TrapFrame.
    /// Nested interrupts use the interrupt stack as well. This feature uses
    /// mscratch to store the user's stack pointer. While not in an interrupt,
    /// mscratch must be zero.
    interrupt_stack_size: ?usize = null,
};

pub const Exception = enum(u5) {
    InstructionFault = 0x1,
    IllegalInstruction = 0x2,
    Breakpoint = 0x3,
    LoadFault = 0x5,
    StoreFault = 0x7,
    UserEnvCall = 0x8,
    MachineEnvCall = 0xb,
};

pub const Interrupt = enum(u5) {
    interrupt1 = 1,
    interrupt2 = 2,
    interrupt3 = 3,
    interrupt4 = 4,
    interrupt5 = 5,
    interrupt6 = 6,
    interrupt7 = 7,
    interrupt8 = 8,
    interrupt9 = 9,
    interrupt10 = 10,
    interrupt11 = 11,
    interrupt12 = 12,
    interrupt13 = 13,
    interrupt14 = 14,
    interrupt15 = 15,
    interrupt16 = 16,
    interrupt17 = 17,
    interrupt18 = 18,
    interrupt19 = 19,
    interrupt20 = 20,
    interrupt21 = 21,
    interrupt22 = 22,
    interrupt23 = 23,
    interrupt24 = 24,
    interrupt25 = 25,
    interrupt26 = 26,
    interrupt27 = 27,
    interrupt28 = 28,
    interrupt29 = 29,
    interrupt30 = 30,
    interrupt31 = 31,
};

pub const InterruptHandler = union(enum) {
    /// No state is saved. Do everything yourself. Interrupts are disabled
    /// while it is executing.
    naked: *const fn () callconv(.naked) void,
    /// State pushed on the stack. Handler can be interrupted by higher
    /// priority interrupts.
    c: *const fn (*TrapFrame) callconv(.c) void,
};

pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = enum { Exception }, .HandlerFn = InterruptHandler },
    .{ .InterruptEnum = Interrupt, .HandlerFn = InterruptHandler },
});

pub const interrupt = struct {
    pub const globally_enabled = riscv32_common.interrupt.globally_enabled;
    pub const enable_interrupts = riscv32_common.interrupt.enable_interrupts;
    pub const disable_interrupts = riscv32_common.interrupt.disable_interrupts;

    const INTERRUPT_CORE0 = microzig.chip.peripherals.INTERRUPT_CORE0;

    pub fn is_enabled(int: Interrupt) bool {
        return INTERRUPT_CORE0.CPU_INT_ENABLE.raw & (@as(u32, 1) << @intFromEnum(int)) != 0;
    }

    pub fn enable(int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_ENABLE.raw |= @as(u32, 1) << @intFromEnum(int);
    }

    pub fn disable(int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_ENABLE.raw &= ~(@as(u32, 1) << @intFromEnum(int));
    }

    /// Checks if a given interrupt is pending.
    pub fn is_pending(int: Interrupt) bool {
        return INTERRUPT_CORE0.CPU_INT_EIP_STATUS.raw & (@as(u32, 1) << @intFromEnum(int)) != 0;
    }

    /// Clears the pending state of claimed (executing) edge-type interrupt only.
    /// NOTE: Pending state of an unclaimed (not executing) edge type interrupt can be flushed,
    /// if required, by first disabling it and only then call clearing it.
    pub fn clear_pending(int: Interrupt) void {
        INTERRUPT_CORE0.CPU_INT_CLEAR.raw |= @as(u32, 1) << @intFromEnum(int);
    }

    pub const Priority = enum(u4) {
        /// Setting this priority masks the interrupt.
        zero = 0,
        lowest = 1,
        highest = 15,

        _,
    };

    /// Sets the priority of an interrupt. Interrupts with priorities zero or less than the priority
    /// threshold value in are masked.
    pub fn set_priority(int: Interrupt, priority: Priority) void {
        get_priority_register_for(int).* = @intFromEnum(priority);
    }

    pub fn get_priority(int: Interrupt) Priority {
        return @enumFromInt(get_priority_register_for(int).*);
    }

    fn get_priority_register_for(int: Interrupt) *volatile u32 {
        // using CPU_INT_PRI_0 (which should be reserved because interrupts start from one) here so
        // that when I offset the register I don't have to subtract one from the interrupt number.
        const base: usize = @intFromPtr(&INTERRUPT_CORE0.CPU_INT_PRI_0);
        const reg: *volatile u32 = @ptrFromInt(base + @sizeOf(u32) * @as(usize, @intFromEnum(int)));
        return reg;
    }

    /// Set threshold for interrupt assertion. Only when the interrupt priority is equal to or
    /// higher than this threshold, the cpu will respond to this interrupt.
    pub fn set_priority_threshold(priority: Priority) void {
        INTERRUPT_CORE0.CPU_INT_THRESH.write(.{
            .CPU_INT_THRESH = @intFromEnum(priority),
        });
    }

    pub fn get_priority_threshold() Priority {
        return @enumFromInt(INTERRUPT_CORE0.CPU_INT_THRESH.read().CPU_INT_THRESH);
    }

    pub const Type = enum(u1) {
        level = 0,
        edge = 1,
    };

    pub fn set_type(int: Interrupt, typ: Type) void {
        const num = @intFromEnum(int);
        switch (typ) {
            .level => INTERRUPT_CORE0.CPU_INT_TYPE.raw &= ~(@as(u32, 1) << num),
            .edge => INTERRUPT_CORE0.CPU_INT_TYPE.raw |= @as(u32, 1) << num,
        }
    }

    pub fn get_type(int: Interrupt) Type {
        const num = @intFromEnum(int);
        return @enumFromInt(INTERRUPT_CORE0.CPU_INT_TYPE.raw & (@as(u32, 1) << num) >> num);
    }

    pub const Source = enum(u6) {
        wifi_mac = 0,
        wifi_mac_nmi = 1,
        wifi_pwr = 2,
        wifi_bb = 3,
        bt_mac = 4,
        bt_bb = 5,
        bt_bb_nmi = 6,
        rwbt = 7,
        rwble = 8,
        rwbt_nmi = 9,
        rwble_nmi = 10,
        i2c_master = 11,
        slc0 = 12,
        slc1 = 13,
        apb_ctrl = 14,
        uhci0 = 15,
        gpio = 16,
        gpio_nmi = 17,
        spi1 = 18,
        spi2 = 19,
        i2s0 = 20,
        uart0 = 21,
        uart1 = 22,
        ledc = 23,
        efuse = 24,
        twai0 = 25,
        usb_device = 26,
        rtc_core = 27,
        rmt = 28,
        i2c_ext0 = 29,
        timer1 = 30,
        timer2 = 31,
        tg0_t0_level = 32,
        tg0_wdt_level = 33,
        tg1_t0_level = 34,
        tg1_wdt_level = 35,
        cache_ia = 36,
        systimer_target0 = 37,
        systimer_target1 = 38,
        systimer_target2 = 39,
        spi_mem_reject_cache = 40,
        icache_preload0 = 41,
        icache_sync0 = 42,
        apb_adc = 43,
        dma_ch0 = 44,
        dma_ch1 = 45,
        dma_ch2 = 46,
        rsa = 47,
        aes = 48,
        sha = 49,
        from_cpu_intr0 = 50,
        from_cpu_intr1 = 51,
        from_cpu_intr2 = 52,
        from_cpu_intr3 = 53,
        assist_debug = 54,
        dma_apbperi_pms = 55,
        core0_iram0_pms = 56,
        core0_dram0_pms = 57,
        core0_pif_pms = 58,
        core0_pif_pms_size = 59,
        bak_pms_violate = 60,
        cache_core0_acs = 61,
    };

    pub fn map(source: Source, maybe_int: ?Interrupt) void {
        get_source_map_register_for(source).* = if (maybe_int) |int| @intFromEnum(int) else 0;
    }

    pub fn get_mapped_interrupt(source: Source) ?Interrupt {
        const source_raw: u4 = @truncate(get_source_map_register_for(source).*);
        if (source_raw != 0) {
            return @enumFromInt(source_raw);
        } else {
            return null;
        }
    }

    fn get_source_map_register_for(source: Source) *volatile u32 {
        // using MAC_INTR_MAP here as it's the first map register.
        const base: usize = @intFromPtr(&INTERRUPT_CORE0.MAC_INTR_MAP);
        return @ptrFromInt(base + @sizeOf(u32) * @as(usize, @intFromEnum(source)));
    }

    // TODO: implement some sort of masking so as to only check sources you
    // care about
    pub const SourceIterator = struct {
        index: usize,
        status_reg: u32,

        pub fn init() SourceIterator {
            return .{
                .index = 0,
                .status_reg = INTERRUPT_CORE0.INTR_STATUS_REG_0.raw,
            };
        }

        pub fn next(iter: *SourceIterator) ?Source {
            var leading_zeroes = @ctz(iter.status_reg);
            if (leading_zeroes == @bitSizeOf(u32)) {
                if (iter.index >= 32) {
                    return null;
                }
                iter.status_reg = INTERRUPT_CORE0.INTR_STATUS_REG_1.raw;
                leading_zeroes = @ctz(iter.status_reg);
                if (leading_zeroes == @bitSizeOf(u32)) {
                    return null;
                }
                iter.index = 32;
            }

            iter.index += leading_zeroes;
            iter.status_reg >>= @truncate(leading_zeroes + 1);

            return @enumFromInt(iter.index);
        }
    };
};

pub const nop = riscv32_common.nop;
pub const wfi = riscv32_common.wfi;
pub const fence = riscv32_common.fence;

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    comptime {
        if (cpu_config.boot_mode == .direct) {
            if (microzig.config.ram_image) {
                @compileError("RAM images are not supported in direct boot mode");
            }

            // See this:
            // https://github.com/espressif/esp32c3-direct-boot-example

            // Direct Boot: does not support Security Boot and programs run directly in flash. To enable this mode, make
            // sure that the first two words of the bin file downloading to flash (address: 0x42000000) are 0xaedb041d.

            // In this case, the ROM bootloader sets up Flash MMU to map 4 MB of Flash to
            // addresses 0x42000000 (for code execution) and 0x3C000000 (for read-only data
            // access). The bootloader then jumps to address 0x42000008, i.e. to the
            // instruction at offset 8 in flash, immediately after the magic numbers.

            asm (
                \\.extern _start
                \\.section microzig_flash_start
                \\.align 4
                \\.byte 0x1d, 0x04, 0xdb, 0xae
                \\.byte 0x1d, 0x04, 0xdb, 0xae
            );
        }
    }

    const _start_link_section = if (microzig.config.ram_image)
        "microzig_ram_start"
    else
        "microzig_flash_start";

    fn _start() linksection(_start_link_section) callconv(.c) noreturn {
        interrupt.disable_interrupts();

        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );

        const eos = comptime microzig.utilities.get_end_of_stack();
        asm volatile (
            \\mv sp, %[eos]
            \\
            :
            : [eos] "r" (@as(u32, @intFromPtr(eos))),
        );

        switch (cpu_config.boot_mode) {
            .direct => microzig.utilities.initialize_system_memories(.all),
            .image => microzig.utilities.initialize_system_memories(.bss_only),
        }

        init_interrupts();

        interrupt.enable_interrupts();

        microzig_main();
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
}

/// Gets interrupts into a known state after the bootloader.
fn init_interrupts() void {
    // unmap all sources
    for (std.enums.values(interrupt.Source)) |source| {
        interrupt.map(source, null);
    }

    interrupt.set_priority_threshold(.zero);

    for (std.enums.values(Interrupt)) |int| {
        interrupt.set_type(int, .level);
        interrupt.set_priority(int, .lowest);
        interrupt.disable(int);
    }

    csr.mtvec.write(.{
        .mode = .vectored,
        .base = @intCast(@intFromPtr(&_vector_table) >> 2),
    });

    if (interrupt_stack_size != null) {
        csr.mscratch.write_raw(0);
    }
}

pub const TrapFrame = extern struct {
    ra: usize,
    t0: usize,
    t1: usize,
    t2: usize,
    t3: usize,
    t4: usize,
    t5: usize,
    t6: usize,
    a0: usize,
    a1: usize,
    a2: usize,
    a3: usize,
    a4: usize,
    a5: usize,
    a6: usize,
    a7: usize,
};

const interrupt_stack_size = microzig.options.cpu.interrupt_stack_size;
pub var interrupt_stack: [std.mem.alignForward(usize, interrupt_stack_size orelse 0, 16)]u8 align(16) = undefined;

fn _vector_table() align(256) linksection(".ram_vectors") callconv(.naked) void {
    const interrupt_jump_asm, const interrupt_c_stubs_asm = comptime blk: {
        var interrupt_jump_asm: []const u8 = "";
        var interrupt_c_stubs_asm: []const u8 = "";

        for (std.meta.fieldNames(InterruptOptions)) |field_name| {
            const handler: InterruptHandler = @field(microzig.options.interrupts, field_name) orelse .{ .c = &unhandled };
            switch (handler) {
                .naked => |naked_handler| {
                    @export(naked_handler, .{
                        .name = std.fmt.comptimePrint("_{s}_handler_naked", .{field_name}),
                    });

                    interrupt_jump_asm = interrupt_jump_asm ++ std.fmt.comptimePrint(
                        \\.balign 4
                        \\    j _{s}_handler_naked
                        \\
                    , .{field_name});
                },
                .c => |c_handler| {
                    @export(c_handler, .{
                        .name = std.fmt.comptimePrint("_{s}_handler_c", .{field_name}),
                    });

                    interrupt_jump_asm = interrupt_jump_asm ++ std.fmt.comptimePrint(
                        \\.balign 4
                        \\    j _{s}_stub
                        \\
                    , .{field_name});

                    interrupt_c_stubs_asm = interrupt_c_stubs_asm ++ std.fmt.comptimePrint(
                        \\_{[name]s}_stub:
                        \\    addi sp, sp, -16*4
                        \\    sw ra, 0(sp)
                        \\    la ra, _{[name]s}_handler_c
                        \\    j trap_common
                        \\
                    , .{ .name = field_name });
                },
            }
        }

        @export(&_handle_interrupt, .{ .name = "_handle_interrupt" });

        break :blk .{ interrupt_jump_asm, interrupt_c_stubs_asm };
    };

    // adapted from https://github.com/esp-rs/esp-hal/blob/main/esp-riscv-rt/src/lib.rs
    asm volatile (
        \\
    ++ interrupt_jump_asm ++ interrupt_c_stubs_asm ++
        \\trap_common:
        \\    sw t0, 1*4(sp)
        \\    sw t1, 2*4(sp)
        \\    sw t2, 3*4(sp)
        \\    sw t3, 4*4(sp)
        \\    sw t4, 5*4(sp)
        \\    sw t5, 6*4(sp)
        \\    sw t6, 7*4(sp)
        \\    sw a0, 8*4(sp)
        \\    sw a1, 9*4(sp)
        \\    sw a2, 10*4(sp)
        \\    sw a3, 11*4(sp)
        \\    sw a4, 12*4(sp)
        \\    sw a5, 13*4(sp)
        \\    sw a6, 14*4(sp)
        \\    sw a7, 15*4(sp)
        \\
        \\    mv a0, sp       # Pass a pointer to TrapFrame to the handler function
        \\    mv a1, ra       # Save address of handler function
        \\
        ++ (if (interrupt_stack_size != null)
            // switch to interrupt stack if not nested
            \\    csrr t0, mscratch
            \\    bnez t0, 1f
            \\    csrw mscratch, sp
            \\    la sp, %[interrupt_stack_top]
            \\    jal ra, _handle_interrupt
            \\    csrrw sp, mscratch, x0
            \\    j 2f
            \\1:
            \\    jal ra, _handle_interrupt
            \\2:
            \\
        else
            \\    jal ra, _handle_interrupt
            \\
        ) ++
        \\
        \\    lw ra, 0*4(sp)
        \\    lw t0, 1*4(sp)
        \\    lw t1, 2*4(sp)
        \\    lw t2, 3*4(sp)
        \\    lw t3, 4*4(sp)
        \\    lw t4, 5*4(sp)
        \\    lw t5, 6*4(sp)
        \\    lw t6, 7*4(sp)
        \\    lw a0, 8*4(sp)
        \\    lw a1, 9*4(sp)
        \\    lw a2, 10*4(sp)
        \\    lw a3, 11*4(sp)
        \\    lw a4, 12*4(sp)
        \\    lw a5, 13*4(sp)
        \\    lw a6, 14*4(sp)
        \\    lw a7, 15*4(sp)
        \\
        \\    addi sp, sp, 16*4 # This removes the frame we allocated from the stack
        \\
        \\    mret

    :
    : [interrupt_stack_top] "i" (if (interrupt_stack_size != null)
        interrupt_stack[interrupt_stack.len..].ptr
    else {}),
    );
}

fn unhandled(_: *TrapFrame) linksection(".ram_text") callconv(.c) void {
    const mcause = csr.mcause.read();

    if (mcause.is_interrupt != 0) {
        std.log.err("unhandled interrupt {} occurred!", .{mcause.code});
    } else {
        const exception: Exception = @enumFromInt(mcause.code);
        std.log.err("unhandled exception {s} occurred at {x}!", .{ @tagName(exception), csr.mepc.read_raw() });

        switch (exception) {
            .InstructionFault => std.log.err("faulting address: {x}", .{csr.mtval.read_raw()}),
            .LoadFault => std.log.err("faulting address: {x}", .{csr.mtval.read_raw()}),
            else => {},
        }
    }

    @panic("unhandled trap");
}

fn _handle_interrupt(
    trap_frame: *TrapFrame,
    handler: *const fn (*TrapFrame) callconv(.c) void,
) linksection(".ram_text") callconv(.c) void {
    const mcause = csr.mcause.read();

    if (mcause.is_interrupt != 0) {
        // interrupt

        const int: Interrupt = @enumFromInt(mcause.code);
        const priority = interrupt.get_priority(int);

        // low priority interrupts can be preempted by higher priority interrupts
        if (@intFromEnum(priority) < 15) {
            const mepc = csr.mepc.read_raw();
            const mstatus = csr.mstatus.read_raw();

            const prev_thresh = interrupt.get_priority_threshold();
            interrupt.set_priority_threshold(@enumFromInt(@intFromEnum(priority) + 1));

            interrupt.enable_interrupts();

            handler(trap_frame);

            interrupt.disable_interrupts();

            interrupt.set_priority_threshold(prev_thresh);

            csr.mepc.write_raw(mepc);
            csr.mstatus.write_raw(mstatus);
        } else {
            handler(trap_frame);
        }
    } else {
        // exception
        handler(trap_frame);
    }
}

pub const csr = struct {
    pub const mvendorid = riscv32_common.csr.mvendorid;
    pub const marchid = riscv32_common.csr.marchid;
    pub const mimpid = riscv32_common.csr.mimpid;
    pub const mhartid = riscv32_common.csr.mhartid;

    pub const mstatus = riscv32_common.csr.mstatus;
    pub const misa = riscv32_common.csr.misa;
    pub const mtvec = riscv32_common.csr.mtvec;

    pub const mscratch = riscv32_common.csr.mscratch;
    pub const mepc = riscv32_common.csr.mepc;
    pub const mcause = riscv32_common.csr.mcause;
    pub const mtval = riscv32_common.csr.mtval;

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

    pub const tselect = riscv32_common.csr.tselect;
    pub const tdata1 = riscv32_common.csr.tdata1;
    pub const tdata2 = riscv32_common.csr.tdata2;
    pub const tcontrol = Csr(0x7A5, packed struct {
        reserved0: u3,
        mte: u1,
        reserved1: u3,
        mpte: u1,
        reserved2: u24,
    });

    pub const dcsr = riscv32_common.csr.dcsr;
    pub const dpc = riscv32_common.csr.dpc;
    pub const dscratch0 = riscv32_common.csr.dscratch0;
    pub const dscratch1 = riscv32_common.csr.dscratch1;

    pub const mpcer = Csr(0x7E0, packed struct {
        cycle: u1,
        inst: u1,
        ld_hazard: u1,
        jmp_hazard: u1,
        idle: u1,
        load: u1,
        store: u1,
        jmp_uncond: u1,
        branch: u1,
        branch_taken: u1,
        inst_comp: u1,
        reserved0: u21,
    });
    pub const mpcmr = Csr(0x7E1, packed struct {
        count_en: u1,
        count_sat: u1,
        reserved0: u30,
    });
    pub const mpccr = Csr(0x7E2, u32);

    pub const cpu_gpio_oen = Csr(0x803, u32);
    pub const cpu_gpio_in = Csr(0x804, u32);
    pub const cpu_gpio_out = Csr(0x805, u32);

    pub const Csr = riscv32_common.csr.Csr;
};
