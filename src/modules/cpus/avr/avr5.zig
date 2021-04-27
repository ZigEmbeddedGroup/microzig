const std = @import("std");

pub fn sei() void {
    asm volatile ("sei");
}

pub fn cli() void {
    asm volatile ("cli");
}

pub const startup_logic = struct {
    comptime {
        asm (
            \\.section microzig_flash_start
            \\ jmp _start
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
            \\ jmp _unhandled_vector
        );
    }

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
