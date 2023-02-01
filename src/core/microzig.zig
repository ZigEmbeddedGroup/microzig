//! This is the entry point and root file of microzig.
//! If you do a @import("microzig"), you'll *basically* get this file.
//!
//! But microzig employs a proxy tactic

const std = @import("std");
const root = @import("root");
const builtin = @import("builtin");

/// The app that is currently built.
pub const app = @import("app");

/// Contains build-time generated configuration options for microzig.
/// Contains a CPU target description, chip, board and cpu information
/// and so on.
pub const config = @import("microzig-config");

/// Provides access to the low level features of the current microchip.
pub const chip = @import("chip");

/// Provides access to board features or is `void` when no board is present.
pub const board = if (config.has_board) @import("board") else void;

/// Provides access to the low level features of the CPU.
pub const cpu = @import("cpu");

pub const hal = @import("hal");

/// Module that helps with interrupt handling.
pub const interrupts = @import("interrupts.zig");

/// Module that provides clock related functions
pub const clock = @import("clock.zig");

pub const gpio = @import("gpio.zig");
pub const Gpio = gpio.Gpio;

pub const pin = @import("pin.zig");
pub const Pin = pin.Pin;

pub const uart = @import("uart.zig");
pub const Uart = uart.Uart;

pub const spi = @import("spi.zig");
pub const SpiBus = spi.SpiBus;

pub const i2c = @import("i2c.zig");
pub const I2CController = i2c.I2CController;

pub const debug = @import("debug.zig");

pub const mmio = @import("mmio.zig");

const options_override = if (@hasDecl(app, "std_options")) app.std_options else struct {};
pub const std_options = struct {
    pub usingnamespace options_override;

    // Conditionally provide a default no-op logFn if app does not have one
    // defined. Parts of microzig use the stdlib logging facility and
    // compilations will now fail on freestanding systems that use it but do
    // not explicitly set `root.std_options.logFn`
    pub usingnamespace if (!@hasDecl(options_override, "logFn"))
        struct {
            pub fn logFn(
                comptime message_level: std.log.Level,
                comptime scope: @Type(.EnumLiteral),
                comptime format: []const u8,
                args: anytype,
            ) void {
                _ = message_level;
                _ = scope;
                _ = format;
                _ = args;
            }
        }
    else
        struct {};
};

// Allow app to override the os API layer
pub const os = if (@hasDecl(app, "os"))
    app.os
else
    struct {};

// Allow app to override the panic handler
pub const panic = if (@hasDecl(app, "panic"))
    app.panic
else
    microzig_panic;

/// The microzig default panic handler. Will disable interrupts and loop endlessly.
pub fn microzig_panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {

    // utilize logging functions
    std.log.err("microzig PANIC: {s}", .{message});

    if (builtin.cpu.arch != .avr) {
        var index: usize = 0;
        var iter = std.debug.StackIterator.init(@returnAddress(), null);
        while (iter.next()) |address| : (index += 1) {
            if (index == 0) {
                std.log.err("stack trace:", .{});
            }
            std.log.err("{d: >3}: 0x{X:0>8}", .{ index, address });
        }
    }
    if (@import("builtin").mode == .Debug) {
        // attach a breakpoint, this might trigger another
        // panic internally, so only do that in debug mode.
        std.log.info("triggering breakpoint...", .{});
        @breakpoint();
    }
    hang();
}

/// Hangs the processor and will stop doing anything useful. Use with caution!
pub fn hang() noreturn {
    while (true) {
        interrupts.cli();

        // "this loop has side effects, don't optimize the endless loop away please. thanks!"
        asm volatile ("" ::: "memory");
    }
}

// Startup logic:
comptime {
    // Instantiate the startup logic for the given CPU type.
    // This usually implements the `_start` symbol that will populate
    // the sections .data and .bss with the correct data.
    // .rodata is not always necessary to be populated (flash based systems
    // can just index flash, while harvard or flash-less architectures need
    // to copy .rodata into RAM).
    _ = cpu.startup_logic;

    // Export the vector table to flash start if we have any.
    // For a lot of systems, the vector table provides a reset vector
    // that is either called (Cortex-M) or executed (AVR) when initalized.

    // Allow board and chip to override CPU vector table.
    const export_opts = .{
        .name = "vector_table",
        .section = "microzig_flash_start",
        .linkage = .Strong,
    };

    if ((board != void and @hasDecl(board, "vector_table")))
        @export(board.vector_table, export_opts)
    else if (@hasDecl(chip, "vector_table"))
        @export(chip.vector_table, export_opts)
    else if (@hasDecl(cpu, "vector_table"))
        @export(cpu.vector_table, export_opts)
    else if (@hasDecl(app, "interrupts"))
        @compileError("interrupts not configured");
}

/// This is the logical entry point for microzig.
/// It will invoke the main function from the root source file
/// and provides error return handling as well as a event loop if requested.
///
/// Why is this function exported?
/// This is due to the modular design of microzig to allow the "chip" dependency of microzig
/// to call into our main function here. If we would use a normal function call, we'd have a
/// circular dependency between the `microzig` and `chip` package. This function is also likely
/// to be invoked from assembly, so it's also convenient in that regard.
export fn microzig_main() noreturn {
    if (!@hasDecl(app, "main"))
        @compileError("The root source file must provide a public function main!");

    const main = @field(app, "main");
    const info: std.builtin.Type = @typeInfo(@TypeOf(main));

    const invalid_main_msg = "main must be either 'pub fn main() void' or 'pub fn main() !void'.";
    if (info != .Fn or info.Fn.params.len > 0)
        @compileError(invalid_main_msg);

    const return_type = info.Fn.return_type orelse @compileError(invalid_main_msg);

    if (info.Fn.calling_convention == .Async)
        @compileError("TODO: Embedded event loop not supported yet. Please try again later.");

    // A hal can export a default init function that runs before main for
    // procedures like clock configuration. The user may override and customize
    // this functionality by providing their own init function.
    // function.
    if (@hasDecl(app, "init"))
        app.init()
    else if (@hasDecl(hal, "init"))
        hal.init();

    if (@typeInfo(return_type) == .ErrorUnion) {
        main() catch |err| {
            // TODO:
            // - Compute maximum size on the type of "err"
            // - Do not emit error names when std.builtin.strip is set.
            var msg: [64]u8 = undefined;
            @panic(std.fmt.bufPrint(&msg, "main() returned error {s}", .{@errorName(err)}) catch @panic("main() returned error."));
        };
    } else {
        main();
    }

    // main returned, just hang around here a bit
    hang();
}

/// Contains references to the microzig .data and .bss sections, also
/// contains the initial load address for .data if it is in flash.
pub const sections = struct {
    extern var microzig_data_start: anyopaque;
    extern var microzig_data_end: anyopaque;
    extern var microzig_bss_start: anyopaque;
    extern var microzig_bss_end: anyopaque;
    extern const microzig_data_load_start: anyopaque;
};

pub fn initializeSystemMemories() void {
    @setCold(true);

    // fill .bss with zeroes
    {
        const bss_start = @ptrCast([*]u8, &sections.microzig_bss_start);
        const bss_end = @ptrCast([*]u8, &sections.microzig_bss_end);
        const bss_len = @ptrToInt(bss_end) - @ptrToInt(bss_start);

        std.mem.set(u8, bss_start[0..bss_len], 0);
    }

    // load .data from flash
    {
        const data_start = @ptrCast([*]u8, &sections.microzig_data_start);
        const data_end = @ptrCast([*]u8, &sections.microzig_data_end);
        const data_len = @ptrToInt(data_end) - @ptrToInt(data_start);
        const data_src = @ptrCast([*]const u8, &sections.microzig_data_load_start);

        std.mem.copy(u8, data_start[0..data_len], data_src[0..data_len]);
    }
}
