const std = @import("std");
const microzig = @import("microzig");
const root = @import("root");

pub const StatusRegister = enum(u8) {
    // machine information
    mvendorid,
    marchid,
    mimpid,
    mhartid,

    // machine trap setup
    mstatus,
    misa,
    mtvec,
};

pub inline fn setStatusBit(comptime reg: StatusRegister, bits: u32) void {
    asm volatile ("csrrs zero, " ++ @tagName(reg) ++ ", %[value]"
        :
        : [value] "r" (bits),
    );
}

pub inline fn clearStatusBit(comptime reg: StatusRegister, bits: u32) void {
    asm volatile ("csrrc zero, " ++ @tagName(reg) ++ ", %[value]"
        :
        : [value] "r" (bits),
    );
}

pub const interrupt = struct {
    pub inline fn disable_interrupts() void {
        clearStatusBit(.mstatus, 0x08);
    }

    pub inline fn enable_interrupts() void {
        setStatusBit(.mstatus, 0x08);
    }
};

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
        microzig.cpu.interrupt.disable_interrupts();
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
        microzig.cpu.setStatusBit(.mtvec, microzig.config.end_of_stack);
        root.initialize_system_memories();
        microzig_main();
    }

    export fn _rv32_trap() callconv(.c) noreturn {
        while (true) {}
    }

    const vector_table = [_]fn () callconv(.c) noreturn{
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
        _rv32_trap,
    };
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{
        .name = "_start",
    });
}
