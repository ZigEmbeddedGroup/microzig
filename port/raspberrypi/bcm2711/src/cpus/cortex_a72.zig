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
        enable_mmu();

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

/// Identity mapping of the low four gigabytes, one 1 GiB block descriptor per entry. Lives in
/// bss, so it is zeroed before `enable_mmu` fills it in.
var page_table: [512]u64 align(4096) = undefined;

/// Brings the mmu up with a flat identity mapping and turns the caches on.
///
/// This is not an optimization. While the mmu is off every access is treated as
/// Device-nGnRnE, and device memory does not allow unaligned accesses at all, so ordinary
/// compiled code faults as soon as it touches an unaligned field. Anything past the simplest
/// register poking needs the ram to be mapped as Normal memory first.
///
/// The mapping is deliberately blunt: the first three gigabytes are Normal memory and the fourth,
/// which holds the peripheral window at 0xFE000000, is Device. That covers the ram of every
/// Raspberry Pi 4 model up to the 3 GiB mark, which is as much as this port lays claim to.
fn enable_mmu() void {
    const normal_memory = 0; // MAIR attribute 0
    const device_memory = 1; // MAIR attribute 1

    @memset(&page_table, 0);

    for (page_table[0..4], 0..) |*entry, gigabyte| {
        const is_peripheral = gigabyte == 3;

        entry.* = (@as(u64, gigabyte) << 30) |
            0b01 | // a block descriptor, and valid
            (@as(u64, if (is_peripheral) device_memory else normal_memory) << 2) |
            (@as(u64, 0b00) << 6) | // read/write
            (@as(u64, if (is_peripheral) 0b00 else 0b11) << 8) | // inner shareable for normal memory
            (@as(u64, 1) << 10); // access flag, or the first touch faults
    }

    // Attribute 0 is Normal memory, write back and read/write allocate. Attribute 1 is
    // Device-nGnRnE.
    write_special_register("mair_el2", 0x0000_0000_0000_00ff);

    write_special_register("ttbr0_el2", @intFromPtr(&page_table));

    // 39 bit address space over 4 KiB granules, so each level one entry covers a gigabyte.
    // Walks are cacheable and inner shareable, and the output is 40 bits, enough for the 8 GiB
    // model. Bits 23 and 31 are RES1 in the non-VHE layout of this register.
    write_special_register("tcr_el2", 25 | // T0SZ
        (@as(u64, 0b01) << 8) | // IRGN0, write back
        (@as(u64, 0b01) << 10) | // ORGN0, write back
        (@as(u64, 0b11) << 12) | // SH0, inner shareable
        (@as(u64, 0b00) << 14) | // TG0, 4 KiB
        (@as(u64, 0b010) << 16) | // PS, 40 bit
        (@as(u64, 1) << 23) |
        (@as(u64, 1) << 31));

    dsb();
    asm volatile ("tlbi alle2" ::: .{ .memory = true });
    dsb();
    isb();

    // M enables the mmu, C the data cache and I the instruction cache.
    const sctlr = read_special_register("sctlr_el2");
    write_special_register("sctlr_el2", sctlr | (1 << 0) | (1 << 2) | (1 << 12));
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
var handling_exception: bool = false;

fn handle_exception() callconv(.c) noreturn {
    // Reporting a fault goes through the formatter and the uart, either of which can fault in
    // turn. Without this the second fault would re-enter here and the console would fill with
    // half printed messages.
    if (handling_exception) hang();
    handling_exception = true;

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

fn hang() noreturn {
    while (true) wfe();
}

fn write_special_register(comptime name: []const u8, value: u64) void {
    asm volatile ("msr " ++ name ++ ", %[value]"
        :
        : [value] "r" (value),
        : .{ .memory = true });
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
