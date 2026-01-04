const std = @import("std");
const microzig = @import("microzig");
const config = microzig.config;

const Interrupt = if (std.mem.eql(u8, config.chip_name, "MSP430G2553")) enum(u4) {
    TRAPINT = 0,
    PORT1 = 2,
    PORT2 = 3,
    ADC10 = 5,
    USCIAB0TX = 6,
    USCIAB0RX = 7,
    TIMER0_A1 = 8,
    TIMER0_A0 = 9,
    WDT = 10,
    COMPARATORA = 11,
    TIMER1_A1 = 12,
    TIMER1_A0 = 13,
    NMI = 14,
} else if (std.mem.eql(u8, config.chip_name, "MSP430F5529")) enum(u6) {
    RTC = 41,
    PORT2 = 42,
    TIMER2_A1 = 43,
    TIMER2_A0 = 44,
    USCI_B1 = 45,
    USCI_A1 = 46,
    PORT1 = 47,
    TIMER1_A1 = 48,
    TIMER1_A0 = 49,
    DMA = 50,
    USB_UBM = 51,
    TIMER0_A1 = 52,
    TIMER0_A0 = 53,
    ADC12 = 54,
    USCI_B0 = 55,
    USCI_A0 = 56,
    WDT = 57,
    TIMER0_B1 = 58,
    TIMER0_B0 = 59,
    COMP_B = 60,
    UNMI = 61,
    SYSNMI = 62,
};

pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = Interrupt, .HandlerFn = interrupt.Handler },
});

// A placeholder for now
const VectorTable = if (std.mem.eql(u8, config.cpu_name, "MSP430X"))
    extern struct {
        table: [63]interrupt.Handler = [_]interrupt.Handler{.{ .c = interrupt.unhandled }} ** 63,
        RESET: interrupt.Handler,
    }
else if (std.mem.eql(u8, config.cpu_name, "MSP430"))
    extern struct {
        table: [15]interrupt.Handler = [_]interrupt.Handler{.{ .c = interrupt.unhandled }} ** 15,
        RESET: interrupt.Handler,
    }
else
    @compileError("Chip not supported yet");

const vector_table: VectorTable = vector_table: {
    var tmp: VectorTable = .{
        .RESET = .{ .c = startup_logic._start },
    };

    // Apply interrupts
    for (@typeInfo(@TypeOf(microzig.options.interrupts)).@"struct".fields) |field| {
        const maybe_handler = @field(microzig.options.interrupts, field.name);
        tmp.table[@intFromEnum(@field(Interrupt, field.name))] =
            maybe_handler orelse .{ .c = interrupt.unhandled };
    }

    break :vector_table tmp;
};

pub const interrupt = struct {
    // NOTE: We do not have an msp430 interrupt calling convention yet. This
    // means that you need to exit the ISR with RETI
    pub const Handler = extern union {
        naked: *const fn () callconv(.naked) void,
        c: *const fn () callconv(.c) void,
    };

    pub fn unhandled() callconv(.c) void {
        while (true) {}
    }

    pub inline fn disable_interrupts() void {
        // including a nop because it's suggested in literature
        asm volatile (
            \\DINT
            \\NOP
            ::: .{});
    }

    pub inline fn enable_interrupts() void {
        // including a nop because it's suggested in literature
        asm volatile (
            \\NOP
            \\EINT
            ::: .{});
    }
};

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    pub fn _start() callconv(.c) noreturn {
        const stack_init = comptime microzig.utilities.get_end_of_stack();
        asm volatile (
            \\MOV %[stack_init], SP
            :
            : [stack_init] "i" (@as(u32, @intFromPtr(stack_init))),
        );

        microzig.utilities.initialize_system_memories(.auto);
        @call(.never_inline, microzig_main, .{});
    }
};

pub fn export_startup_logic() void {
    @export(&vector_table, .{
        .name = "_vector_table",
        .section = ".isr_vector",
        .linkage = .strong,
    });
    @export(&startup_logic._start, .{
        .name = "_start",
    });
}

export fn memset(dest: [*]u8, ch: u8, count: usize) callconv(.c) [*]u8 {
    // dest: R12
    _ = ch; // R13
    _ = count; // R14
    asm volatile (
        \\  MOV R12, R5
        \\  ADD R5, R14
        \\memset_loop:
        \\  CMP   R5, R12
        \\  JEQ   memset_done
        \\  MOV.B R13, @R12
        \\  INC   R12
        \\  JMP   memset_loop
        \\memset_done:
        \\  SUB R12, R14
        ::: .{
            .r5 = true,
            // r12 doesn't go in the clobbers because it is restored before exiting
            .r13 = true,
            .r14 = true,
        });

    return dest;
}

export fn memcpy(dest: [*]u8, src: [*]const u8, count: usize) callconv(.c) [*]u8 {
    // dest: R12
    _ = src; // R13
    _ = count; // R14
    asm volatile (
        \\  MOV R5, R12
        \\  ADD R5, R14
        \\memcpy_loop:
        \\  CMP  R5, R12
        \\  JEQ  memcpy_done
        \\  MOV.B @R13, @R12
        \\  INC   R12
        \\  INC   R13
        \\memcpy_done:
        \\  SUB R12, R14
        ::: .{
            .r5 = true,
            // r12 doesn't go in the clobbers because it is restored before exiting
            .r13 = true,
            .r14 = true,
        });

    return dest;
}

export fn abort() callconv(.c) void {
    @breakpoint();
    while (true) {}
}
