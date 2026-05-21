const std = @import("std");
const microzig = @import("microzig");

/// @breakpoint() on AVR is calling abort, so we export simple function that is calling hang
pub fn abort() noreturn {
    microzig.hang();
}

pub const interrupt = struct {
    pub fn enable_interrupts() void {
        asm volatile ("sei");
    }

    pub fn disable_interrupts() void {
        asm volatile ("cli");
    }
};

/// AVR interrupt handler function type.
pub const HandlerFn = extern union {
    signal: *const fn () callconv(.avr_signal) void,
    interrupt: *const fn () callconv(.avr_interrupt) void,
    naked: *const fn () callconv(.naked) noreturn,
};

/// Complete list of interrupt values based on the chip's `interrupts` array.
pub const Interrupt = microzig.utilities.GenerateInterruptEnum(i32);

/// Allowable `interrupt` options for microzig.options.
pub const InterruptOptions = microzig.utilities.GenerateInterruptOptions(&.{
    .{ .InterruptEnum = Interrupt, .HandlerFn = HandlerFn },
});

pub inline fn sbi(comptime reg: u5, comptime bit: u3) void {
    asm volatile ("sbi %[reg], %[bit]"
        :
        : [reg] "I" (reg),
          [bit] "I" (bit),
    );
}

pub inline fn cbi(comptime reg: u5, comptime bit: u3) void {
    asm volatile ("cbi %[reg], %[bit]"
        :
        : [reg] "I" (reg),
          [bit] "I" (bit),
    );
}

/// The different jump instructions allowed in the "vector table"
pub const JumpInstruction = enum {
    jmp,
    rjmp,

    pub fn to_string(insn: JumpInstruction) []const u8 {
        return switch (insn) {
            .jmp => "jmp",
            .rjmp => "rjmp",
        };
    }
};

/// AVR jumps execution to a specific offset in memory for a particular
/// interrupt. The way to build an interrupt vector is to have a series of jump
/// instructions in this region of memory. The CPU will jump to an entry in the
/// table, and then the instruction will cause it to jump to the configured
/// handler.
///
/// Zig's comptime helps because we generate the assembly at comptime, and it is
/// later instantiated using inline asm.
pub fn generate_vector_table_asm(comptime jump_insn: JumpInstruction) []const u8 {
    const fields = std.meta.fields(microzig.chip.VectorTable);
    std.debug.assert(std.mem.eql(u8, "RESET", fields[0].name));
    var asm_str: []const u8 = jump_insn.to_string() ++ " microzig_start\n";

    const interrupt_options = microzig.options.interrupts;

    for (fields[1..]) |field| {
        const handler = @field(interrupt_options, field.name);
        if (handler) |func| {
            const isr = make_isr_handler(field.name, func);
            asm_str = asm_str ++ jump_insn.to_string() ++ isr.exported_name ++ "\n";
        } else {
            asm_str = asm_str ++ jump_insn.to_string() ++ " microzig_unhandled_vector\n";
        }
    }

    return asm_str;
}

fn make_isr_handler(comptime name: []const u8, comptime func: anytype) type {
    const calling_convention = switch (@typeInfo(@TypeOf(func))) {
        .@"fn" => |info| info.calling_convention,
        .pointer => |info| switch (@typeInfo(info.child)) {
            .@"fn" => |fn_info| fn_info.calling_convention,
            else => @compileError("Declarations in 'interrupts' namespace must all be functions. '" ++ name ++ "' is not a function"),
        },
        else => @compileError("Declarations in 'interrupts' namespace must all be functions. '" ++ name ++ "' is not a function"),
    };

    switch (calling_convention) {
        .auto, .avr_signal, .avr_interrupt => {},
        else => @compileError("Calling conventions for interrupts must be 'avr_interrupt', 'avr_signal', or unspecified. The avr_signal calling convention leaves global interrupts disabled during the ISR, where avr_interrupt enables global interrupts for nested ISRs."),
    }

    return struct {
        pub const exported_name = "microzig_isr_" ++ name;

        comptime {
            @export(func, .{ .name = exported_name });
        }
    };
}

pub const startup_logic = struct {
    export fn microzig_unhandled_vector() callconv(.c) noreturn {
        @panic("Unhandled interrupt");
    }

    extern fn microzig_main() noreturn;

    export fn microzig_start() callconv(.c) noreturn {
        // At startup the stack pointer is at the end of RAM
        // so, no need to set it manually!

        copy_data_to_ram();
        clear_bss();

        microzig_main();
    }

    fn copy_data_to_ram() void {
        asm volatile (
            \\  ; load Z register with the address of the data in flash
            \\  ldi r30, lo8(microzig_data_load_start)
            \\  ldi r31, hi8(microzig_data_load_start)
            \\  ; load X register with address of the data in ram
            \\  ldi r26, lo8(microzig_data_start)
            \\  ldi r27, hi8(microzig_data_start)
            \\  ; load address of end of the data in ram
            \\  ldi r24, lo8(microzig_data_end)
            \\  ldi r25, hi8(microzig_data_end)
            \\  rjmp .L2
            \\
            \\.L1:
            \\  lpm r18, Z+ ; copy from Z into r18 and increment Z
            \\  st X+, r18  ; store r18 at location X and increment X
            \\
            \\.L2:
            \\  cp r26, r24
            \\  cpc r27, r25 ; check and branch if we are at the end of data
            \\  brne .L1
        );
        // Probably a good idea to add clobbers here, but compiler doesn't seem to care
    }

    fn clear_bss() void {
        asm volatile (
            \\  ; load X register with the beginning of bss section
            \\  ldi r26, lo8(microzig_bss_start)
            \\  ldi r27, hi8(microzig_bss_start)
            \\  ; load end of the bss in registers
            \\  ldi r24, lo8(microzig_bss_end)
            \\  ldi r25, hi8(microzig_bss_end)
            \\  ldi r18, 0x00
            \\  rjmp .L4
            \\
            \\.L3:
            \\  st X+, r18
            \\
            \\.L4:
            \\  cp r26, r24
            \\  cpc r27, r25 ; check and branch if we are at the end of bss
            \\  brne .L3
        );
        // Probably a good idea to add clobbers here, but compiler doesn't seem to care
    }
};
