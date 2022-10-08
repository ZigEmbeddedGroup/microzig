const std = @import("std");
const microzig = @import("microzig");

pub const startup_logic = struct {
    comptime {
        // See this:
        // https://github.com/espressif/esp32c3-direct-boot-example

        // Direct Boot: does not support Security Boot and programs run directly in flash. To enable this mode, make
        // sure that the first two words of the bin file downloading to flash (address: 0x42000000) are 0xaedb041d.

        // In this case, the ROM bootloader sets up Flash MMU to map 4 MB of Flash to
        // addresses 0x42000000 (for code execution) and 0x3C000000 (for read-only data
        // access). The bootloader then jumps to address 0x42000008, i.e. to the
        // instruction at offset 8 in flash, immediately after the magic numbers.

        asm (std.fmt.comptimePrint(".equ MICROZIG_INITIAL_STACK, {}", .{microzig.config.end_of_stack}));

        asm (
            \\.extern _start
            \\.section microzig_flash_start
            \\.align 4
            \\.byte 0x1d, 0x04, 0xdb, 0xae
            \\.byte 0x1d, 0x04, 0xdb, 0xae
        );
    }

    extern fn microzig_main() noreturn;

    export fn _start() linksection("microzig_flash_start") callconv(.C) noreturn {
        asm volatile (
            \\li sp, MICROZIG_INITIAL_STACK
            \\lui  a0, %%hi(_rv32_trap)
            \\addi a0, a0, %%lo(_rv32_trap)
            \\sw t0, 0x305(zero)
        );

        microzig.initializeSystemMemories();
        microzig_main();
    }

    export fn _rv32_trap() callconv(.C) noreturn {
        while (true) {}
    }
};
