const std = @import("std");
const microzig = @import("microzig");
const root = @import("root");

const common = @import("esp_riscv_common.zig");

pub const Interrupt = common.Interrupt;
pub const InterruptHandler = common.InterruptHandler;
pub const InterruptOptions = common.InterruptOptions;
pub const InterruptStack = common.InterruptStack;

pub const interrupt = common.interrupt;

pub const wfi = common.wfi;
pub const wfe = common.wfe;

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

        asm (
            \\.extern _start
            \\.section microzig_flash_start
            \\.align 4
            \\.byte 0x1d, 0x04, 0xdb, 0xae
            \\.byte 0x1d, 0x04, 0xdb, 0xae
        );
    }

    extern fn microzig_main() noreturn;

    pub fn _start() linksection("microzig_flash_start") callconv(.c) noreturn {
        interrupt.disable_interrupts();

        asm volatile ("mv sp, %[eos]"
            :
            : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
        );

        asm volatile (
            \\.option push
            \\.option norelax
            \\la gp, __global_pointer$
            \\.option pop
        );

        root.initialize_system_memories();

        common.init_interrupts();

        microzig_main();
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
}
