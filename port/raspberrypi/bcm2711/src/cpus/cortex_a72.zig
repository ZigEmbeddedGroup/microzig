//! Cortex-A72 in AArch64 mode, as found on the BCM2711.
//!
//! This is an application core, not a microcontroller core, so the startup here looks different
//! from the other microzig cpus:
//!
//! - The firmware has already loaded the image into ram and jumped to its first byte, there is no
//!   flash to copy out of and no reset vector table to place.
//! - Four cores come out of reset. The stock armstub parks the secondary ones on a spin table,
//!   but this code parks anything that is not core 0 itself so that it also works when the image
//!   is entered directly by all four.
//! - The image is entered at EL2. This port stays at whatever exception level it was handed and
//!   does not drop to EL1, which keeps the bring up small; everything it touches (mmio, the
//!   generic timer) is reachable from EL2.
//! - The mmu and the caches are left off. Every access therefore goes straight to memory, which
//!   is slow but removes the need for page tables during bring up.

const std = @import("std");
const microzig = @import("microzig");

pub const startup_logic = struct {
    extern fn microzig_main() noreturn;

    /// Entry point of the image, and the first byte at 0x80000.
    ///
    /// This has to be naked: a normal function would push a frame onto whatever stack the
    /// firmware happened to leave behind, and would then keep addressing its locals through that
    /// frame after the stack pointer has already been moved. So it only parks the spare cores,
    /// points sp at the top of ram and hands over.
    ///
    /// `__microzig_end_of_stack` is an absolute symbol from the linker script, its address is
    /// the value, which is why it is materialized with adrp/add rather than loaded.
    fn _start() linksection("microzig_ram_start") callconv(.naked) noreturn {
        asm volatile (
        // Park every core but the first one. The stock armstub already holds them on a spin
        // table, this is here so that the image also survives being entered by all four.
            \\  mrs x0, mpidr_el1
            \\  and x0, x0, #0xff
            \\  cbz x0, 1f
            \\0:
            \\  wfe
            \\  b 0b
            \\1:
            \\  adrp x0, __microzig_end_of_stack
            \\  add x0, x0, :lo12:__microzig_end_of_stack
            \\  mov sp, x0
            \\  b microzig_start_main
        );
    }

    /// Runs on our own stack. The firmware loaded .data for us, only .bss needs clearing.
    fn start_main() callconv(.c) noreturn {
        microzig.utilities.initialize_system_memories(.bss_only);

        install_vector_table();

        microzig_main();
    }

    comptime {
        @export(&start_main, .{ .name = "microzig_start_main" });
    }
};

pub fn export_startup_logic() void {
    @export(&startup_logic._start, .{ .name = "_start" });
}

/// Index of the core this code is running on, 0 to 3.
pub fn core_id() u8 {
    return @truncate(read_special_register("mpidr_el1") & 0xff);
}

/// The exception level the image is running at. The firmware hands a 64 bit kernel over at EL2.
pub fn current_el() u2 {
    return @truncate((read_special_register("CurrentEL") >> 2) & 0b11);
}

fn install_vector_table() void {
    const vbar = @intFromPtr(&_vector_table);

    switch (current_el()) {
        2 => asm volatile ("msr vbar_el2, %[vbar]"
            :
            : [vbar] "r" (vbar),
        ),
        else => asm volatile ("msr vbar_el1, %[vbar]"
            :
            : [vbar] "r" (vbar),
        ),
    }

    isb();
}

/// The sixteen entries of an AArch64 exception vector table, 128 bytes apart, aligned to 2 KiB.
///
/// Nothing is dispatched yet: every entry lands in the same handler, which panics with the
/// syndrome and the faulting address. That turns a fault into a readable message instead of a
/// silent lockup, which is what this port needs while it is being brought up.
fn _vector_table() align(2048) callconv(.naked) void {
    asm volatile (blk: {
            var entries: []const u8 = "";
            for (0..16) |_| {
                entries = entries ++
                    \\.balign 128
                    \\  b microzig_handle_exception
                    \\
                ;
            }
            break :blk entries;
        });
}

/// Reports an exception and stops. It never returns, so the vector table above does not bother
/// saving any state before branching here.
fn handle_exception() callconv(.c) noreturn {
    const esr, const elr, const far = switch (current_el()) {
        2 => .{
            read_special_register("esr_el2"),
            read_special_register("elr_el2"),
            read_special_register("far_el2"),
        },
        else => .{
            read_special_register("esr_el1"),
            read_special_register("elr_el1"),
            read_special_register("far_el1"),
        },
    };

    std.log.err("unhandled exception: esr={x} elr={x} far={x}", .{ esr, elr, far });
    @panic("unhandled exception");
}

comptime {
    @export(&handle_exception, .{ .name = "microzig_handle_exception" });
}

fn read_special_register(comptime name: []const u8) u64 {
    return asm volatile ("mrs %[out], " ++ name
        : [out] "=r" (-> u64),
    );
}

pub const interrupt = struct {
    /// Unmasks IRQs and FIQs.
    pub fn enable_interrupts() void {
        asm volatile ("msr daifclr, #3" ::: .{ .memory = true });
    }

    /// Masks IRQs and FIQs.
    pub fn disable_interrupts() void {
        asm volatile ("msr daifset, #3" ::: .{ .memory = true });
    }

    /// True while IRQs are unmasked. DAIF bit 7 is the I flag.
    pub fn globally_enabled() bool {
        return read_special_register("daif") & (1 << 7) == 0;
    }

    /// The GIC-400 is not driven by this port yet, so individual interrupt sources cannot be
    /// masked. Only the global `enable_interrupts` and `disable_interrupts` work.
    pub fn enable(int: anytype) void {
        _ = int;
        @compileError("per interrupt masking needs a GIC-400 driver, which this port does not have yet");
    }

    pub fn disable(int: anytype) void {
        _ = int;
        @compileError("per interrupt masking needs a GIC-400 driver, which this port does not have yet");
    }
};

pub fn nop() void {
    asm volatile ("nop");
}

pub fn wfi() void {
    asm volatile ("wfi");
}

pub fn wfe() void {
    asm volatile ("wfe");
}

pub fn sev() void {
    asm volatile ("sev");
}

/// Instruction synchronization barrier.
pub fn isb() void {
    asm volatile ("isb" ::: .{ .memory = true });
}

/// Data synchronization barrier.
pub fn dsb() void {
    asm volatile ("dsb sy" ::: .{ .memory = true });
}

/// Data memory barrier.
pub fn dmb() void {
    asm volatile ("dmb sy" ::: .{ .memory = true });
}

/// Counter frequency of the ARM generic timer, in Hz. The firmware programs this, on a Pi 4 it
/// comes up at 54 MHz.
pub fn counter_frequency() u64 {
    return read_special_register("cntfrq_el0");
}

/// Current value of the ARM generic timer's physical counter.
pub fn counter() u64 {
    isb();
    return read_special_register("cntpct_el0");
}
