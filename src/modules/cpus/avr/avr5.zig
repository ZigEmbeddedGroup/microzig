const std = @import("std");
const microzig = @import("microzig");

pub inline fn sei() void {
    asm volatile ("sei");
}

pub inline fn cli() void {
    asm volatile ("cli");
}

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

pub const vector_table = blk: {
    std.debug.assert(std.mem.eql(u8, "RESET", std.meta.fields(microzig.chip.VectorTable)[0].name));
    var asm_str: []const u8 = "jmp _start\n";

    const has_interrupts = @hasDecl(microzig.app, "interrupts");
    if (has_interrupts) {
        if (@hasDecl(microzig.app.interrupts, "RESET"))
            @compileError("Not allowed to overload the reset vector");

        inline for (std.meta.declarations(microzig.app.interrupts)) |decl| {
            if (!@hasField(microzig.chip.VectorTable, decl.name)) {
                var msg: []const u8 = "There is no such interrupt as '" ++ decl.name ++ "'. ISRs the 'interrupts' namespace must be one of:\n";
                inline for (std.meta.fields(microzig.chip.VectorTable)) |field| {
                    if (!std.mem.eql(u8, "RESET", field.name)) {
                        msg = msg ++ "    " ++ field.name ++ "\n";
                    }
                }

                @compileError(msg);
            }
        }
    }

    inline for (std.meta.fields(microzig.chip.VectorTable)[1..]) |field| {
        const new_insn = if (has_interrupts) overload: {
            if (@hasDecl(microzig.app.interrupts, field.name)) {
                const handler = @field(microzig.app.interrupts, field.name);
                const calling_convention = switch (@typeInfo(@TypeOf(@field(microzig.app.interrupts, field.name)))) {
                    .Fn => |info| info.calling_convention,
                    else => @compileError("Declarations in 'interrupts' namespace must all be functions. '" ++ field.name ++ "' is not a function"),
                };

                const exported_fn = switch (calling_convention) {
                    .Unspecified => struct {
                        fn wrapper() callconv(.C) void {
                            if (calling_convention == .Unspecified) // TODO: workaround for some weird stage1 bug
                                @call(.{ .modifier = .always_inline }, handler, .{});
                        }
                    }.wrapper,
                    else => @compileError("Just leave interrupt handlers with an unspecified calling convention"),
                };

                const options = .{ .name = field.name, .linkage = .Strong };
                @export(exported_fn, options);
                break :overload "jmp " ++ field.name;
            } else {
                break :overload "jmp _unhandled_vector";
            }
        } else "jmp _unhandled_vector";

        asm_str = asm_str ++ new_insn ++ "\n";
    }

    break :blk asm (asm_str);
};

pub const startup_logic = struct {
    export fn _unhandled_vector() callconv(.Naked) noreturn {
        @panic("Unhandled interrupt");
    }

    extern fn microzig_main() noreturn;

    export fn _start() callconv(.Naked) noreturn {
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
