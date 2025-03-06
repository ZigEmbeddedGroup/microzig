const std = @import("std");
const microzig = @import("microzig");
const root = @import("root");

pub const interrupt = struct {
    pub fn enable_interrupts() void {
        asm volatile ("sei");
    }

    pub fn disable_interrupts() void {
        asm volatile ("cli");
    }
};

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

pub const vector_table_asm = blk: {
    std.debug.assert(std.mem.eql(u8, "RESET", std.meta.fields(microzig.chip.VectorTable)[0].name));
    const asm_str: []const u8 = "jmp microzig_start\n";

    //const has_interrupts = @hasDecl(root, "microzig_options");
    //for (@typeInfo(root.VectorTableOptions).Struct.fields) |field| {
    //    const new_insn = if (has_interrupts) overload: {
    //        const interrupts = root.microzig_options.interrupts;
    //        if (@hasDecl(interrupts, field.name)) {
    //            const handler = @field(interrupts, field.name);

    //            const isr = make_isr_handler(field.name, handler);

    //            break :overload "jmp " ++ isr.exported_name;
    //        } else {
    //            break :overload "jmp microzig_unhandled_vector";
    //        }
    //    } else "jmp microzig_unhandled_vector";

    //    asm_str = asm_str ++ new_insn ++ "\n";
    //}

    break :blk asm_str;
};

fn vector_table() callconv(.Naked) noreturn {
    asm volatile (vector_table_asm);
}

// @breakpoint() on AVR is calling abort, so we export simple function that is calling hang
export fn abort() noreturn {
    microzig.hang();
}

pub fn export_startup_logic() void {
    _ = startup_logic;
    @export(vector_table, .{
        .name = "_start",
    });
}

fn make_isr_handler(comptime name: []const u8, comptime func: anytype) type {
    const calling_convention = switch (@typeInfo(@TypeOf(func))) {
        .Fn => |info| info.calling_convention,
        else => @compileError("Declarations in 'interrupts' namespace must all be functions. '" ++ name ++ "' is not a function"),
    };

    switch (calling_convention) {
        .Unspecified, .Signal, .Interrupt => {},
        else => @compileError("Calling conventions for interrupts must be 'Interrupt', 'Signal', or unspecified. The signal calling convention leaves global interrupts disabled during the ISR, where the interrupt calling conventions enables global interrupts for nested ISRs."),
    }

    return struct {
        pub const exported_name = "microzig_isr_" ++ name;

        pub fn isr_vector() callconv(.Signal) void {
            @call(.always_inline, func, .{});
        }

        comptime {
            const options = .{ .name = exported_name, .linkage = .Strong };
            @export(isr_vector, options);
        }
    };
}

pub const startup_logic = struct {
    export fn microzig_unhandled_vector() callconv(.C) noreturn {
        @panic("Unhandled interrupt");
    }

    extern fn microzig_main() noreturn;

    export fn microzig_start() callconv(.C) noreturn {
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
