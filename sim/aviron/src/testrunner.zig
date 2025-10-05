const std = @import("std");
const builtin = @import("builtin");
const aviron = @import("aviron");
const args_parser = @import("args");
const testconfig = @import("testconfig.zig");

const Cli = struct {
    help: bool = false,
    trace: bool = false,

    name: []const u8 = "",
    config: ?[]const u8 = null,
};

const ExitMode = union(testconfig.ExitType) {
    breakpoint,
    enter_sleep_mode,
    reset_watchdog,
    out_of_gas,
    infinite_loop,
    program_exit,
    system_exit: u8,
};

fn run_test_with_mcu(
    allocator: std.mem.Allocator,
    mcu_name: []const u8,
    test_config: testconfig.TestSuiteConfig,
    options: Cli,
    elf_paths: []const []const u8,
) !void {
    // Use comptime dispatch based on memory sizes (case-insensitive comparison)
    if (std.ascii.eqlIgnoreCase(mcu_name, "ATmega328P")) {
        try run_test(allocator, aviron.mcu.atmega328p, test_config, options, elf_paths);
    } else if (std.ascii.eqlIgnoreCase(mcu_name, "ATtiny816")) {
        try run_test(allocator, aviron.mcu.attiny816, test_config, options, elf_paths);
    } else if (std.ascii.eqlIgnoreCase(mcu_name, "ATmega2560")) {
        try run_test(allocator, aviron.mcu.atmega2560, test_config, options, elf_paths);
    } else if (std.ascii.eqlIgnoreCase(mcu_name, "ATxmega128A4U")) {
        try run_test(allocator, aviron.mcu.xmega128a4u, test_config, options, elf_paths);
    } else {
        std.debug.print("MCU '{s}' not yet supported in test runner\n", .{mcu_name});
        return error.UnsupportedMCU;
    }
}

fn run_test(
    allocator: std.mem.Allocator,
    comptime mcu_config: anytype,
    test_config: testconfig.TestSuiteConfig,
    options: Cli,
    elf_paths: []const []const u8,
) !void {
    var flash_storage = aviron.Flash.Static(mcu_config.flash_size){};
    var sram = aviron.RAM.Static(mcu_config.sram_size){};
    var eeprom = aviron.EEPROM.Static(mcu_config.eeprom_size){};

    var stdout = std.array_list.Managed(u8).init(allocator);
    defer stdout.deinit();

    var stderr = std.array_list.Managed(u8).init(allocator);
    defer stderr.deinit();

    var io = IO{
        .sreg = undefined,
        .sp = mcu_config.sram_base + mcu_config.sram_size - 1,
        .config = test_config,
        .stdin = test_config.stdin,
        .stdout = &stdout,
        .stderr = &stderr,
    };

    const flash_mem = flash_storage.memory();
    var sram_mem = sram.memory();
    const eeprom_mem = eeprom.memory();
    var io_mem = io.memory();

    // Build memory spaces via MCU helper
    const spaces = try aviron.mcu.build_spaces(allocator, mcu_config, &sram_mem, &io_mem);
    defer spaces.deinit(allocator);

    var cpu = aviron.Cpu{
        .trace = options.trace,
        .instruction_set = mcu_config.instruction_set,
        .flash = flash_mem,
        .sram = sram_mem,
        .sram_base = mcu_config.sram_base,
        .eeprom = eeprom_mem,
        .io = io_mem,
        .data = spaces.data,
        .io_space = spaces.io,
        .code_model = mcu_config.code_model,
        .sio = .{
            .ramp_x = mcu_config.special_io.ramp_x,
            .ramp_y = mcu_config.special_io.ramp_y,
            .ramp_z = mcu_config.special_io.ramp_z,
            .ramp_d = mcu_config.special_io.ramp_d,
            .e_ind = mcu_config.special_io.e_ind,
            .sp_l = mcu_config.special_io.sp_l,
            .sp_h = mcu_config.special_io.sp_h,
            .sreg = mcu_config.special_io.sreg,
        },
    };

    io.sreg = &cpu.sreg;

    // Initialize CPU state
    inline for (comptime std.meta.fields(aviron.Cpu.SREG)) |fld| {
        if (@field(test_config.precondition.sreg, fld.name)) |init_value| {
            @field(cpu.sreg, fld.name) = init_value;
        }
    }
    inline for (comptime std.enums.values(aviron.Register)) |reg| {
        if (@field(test_config.precondition, @tagName(reg))) |init_value| {
            cpu.regs[reg.num()] = init_value;
        }
    }

    // Load ELF files
    for (elf_paths) |file_path| {
        var elf_file = try std.fs.cwd().openFile(file_path, .{});
        defer elf_file.close();

        var file_buf: [4096]u8 = undefined;
        var reader = elf_file.reader(&file_buf);

        var header = try std.elf.Header.read(&reader.interface);

        // Set PC to entry point (convert byte address to word address for AVR)
        cpu.pc = @intCast(header.entry / 2);

        var pheaders = header.iterateProgramHeaders(&reader);
        while (try pheaders.next()) |phdr| {
            if (phdr.p_type != std.elf.PT_LOAD)
                continue;

            const dest_mem: []u8 = if (phdr.p_paddr >= 0x0080_0000)
                &sram.data
            else
                &flash_storage.data;

            const addr_masked: u24 = @intCast(phdr.p_paddr & 0x007F_FFFF);
            const target_addr: u24 = if (phdr.p_paddr >= 0x0080_0000)
                addr_masked - @as(u24, mcu_config.sram_base)
            else
                addr_masked;

            try reader.seekTo(phdr.p_offset);
            try reader.interface.readSliceAll(dest_mem[target_addr..][0..phdr.p_filesz]);
            @memset(dest_mem[target_addr + phdr.p_filesz ..][0 .. phdr.p_memsz - phdr.p_filesz], 0);
        }
    }

    // Run the test
    const result = cpu.run(null, null) catch |err| {
        std.debug.print("CPU execution error: {}\n", .{err});
        std.process.exit(1);
    };

    // Check if it was a system exit (via IO)
    const exit_mode: ExitMode = if (io.exit_requested)
        .{ .system_exit = io.exit_code }
    else switch (result) {
        .breakpoint => .breakpoint,
        .enter_sleep_mode => .enter_sleep_mode,
        .reset_watchdog => .reset_watchdog,
        .out_of_gas => .out_of_gas,
        .infinite_loop => .infinite_loop,
        .program_exit => .program_exit,
    };

    // Validate results
    var ok = true;

    if (exit_mode != test_config.exit) {
        std.debug.print("Invalid exit type: Expected {s}, but got {s}.\n", .{
            @tagName(test_config.exit),
            @tagName(exit_mode),
        });
        ok = false;
    } else if (exit_mode == .system_exit and exit_mode.system_exit != test_config.exit_code) {
        std.debug.print("Invalid exit code: Expected {}, but got {}.\n", .{
            test_config.exit_code,
            exit_mode.system_exit,
        });
        ok = false;
    }

    if (!std.mem.eql(u8, stdout.items, test_config.stdout)) {
        std.debug.print("stdout mismatch:\n", .{});
        std.debug.print("expected: '{x}'\n", .{test_config.stdout});
        std.debug.print("actual:   '{x}'\n", .{stdout.items});
        ok = false;
    }

    if (!std.mem.eql(u8, stderr.items, test_config.stderr)) {
        std.debug.print("stderr mismatch:\n", .{});
        std.debug.print("expected: '{x}'\n", .{test_config.stderr});
        std.debug.print("actual:   '{x}'\n", .{stderr.items});
        ok = false;
    }

    // Check each register
    inline for (comptime std.enums.values(aviron.Register)) |reg| {
        const reg_name = comptime @tagName(reg);
        if (@field(test_config.postcondition, reg_name)) |expected| {
            const actual = cpu.regs[reg.num()];
            if (expected != actual) {
                std.debug.print("Invalid register value for register {s}: Expected 0x{X:0>2}, but got 0x{X:0>2}.\n", .{
                    reg_name,
                    expected,
                    actual,
                });
                ok = false;
            }
        }
    }

    inline for (comptime std.meta.fields(aviron.Cpu.SREG)) |fld| {
        if (@field(test_config.postcondition.sreg, fld.name)) |expected_value| {
            const actual_value = @field(cpu.sreg, fld.name);
            if (actual_value != expected_value) {
                std.debug.print("Invalid register value for SREG.{s}: Expected {}, but got {}.\n", .{
                    fld.name,
                    expected_value,
                    actual_value,
                });
                ok = false;
            }
        }
    }

    if (!ok and options.name.len > 0) {
        std.debug.print("test {s} failed.\n", .{options.name});
    }

    std.process.exit(if (ok) 0x00 else 0x01);
}

pub fn main() !u8 {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    var cli = args_parser.parseForCurrentProcess(Cli, allocator, .print) catch return 1;
    defer cli.deinit();

    const config_path = cli.options.config orelse @panic("missing configuration path!");

    const config = blk: {
        var file = try std.fs.cwd().openFile(config_path, .{});
        defer file.close();

        break :blk try testconfig.TestSuiteConfig.load(allocator, file);
    };

    if (cli.positionals.len == 0)
        @panic("usage: aviron [--trace] <elf>");

    // Determine which MCU(s) to test with
    if (config.cpus) |cpus| {
        // Run test against multiple MCUs
        for (cpus) |mcu_name| {
            std.debug.print("Running test with MCU: {s}\n", .{mcu_name});
            try run_test_with_mcu(allocator, mcu_name, config, cli.options, cli.positionals);
        }
    } else {
        // Run test against a single MCU (default to ATmega328P if not specified)
        const mcu_name = config.cpu orelse "ATmega328P";
        try run_test_with_mcu(allocator, mcu_name, config, cli.options, cli.positionals);
    }

    return 0;
}

const IO = struct {
    config: testconfig.TestSuiteConfig,

    scratch_regs: [16]u8 = @splat(0),

    sp: u16,
    sreg: *aviron.Cpu.SREG,

    // RAMP registers for extended addressing (atmega2560)
    ramp_x: u8 = 0,
    ramp_y: u8 = 0,
    ramp_z: u8 = 0,
    ramp_d: u8 = 0,
    e_ind: u8 = 0,

    stdout: *std.array_list.Managed(u8),
    stderr: *std.array_list.Managed(u8),

    stdin: []const u8,

    // Exit status tracking
    exit_requested: bool = false,
    exit_code: u8 = 0,

    pub fn memory(self: *IO) aviron.IO {
        return aviron.IO{
            .ctx = self,
            .vtable = &vtable,
        };
    }

    pub const vtable = aviron.IO.VTable{
        .readFn = read,
        .writeFn = write,
        .checkExitFn = check_exit,
    };

    // This is our own "debug" device with it's own debug addresses:
    const Register = enum(aviron.IO.Address) {
        exit = 0, // read: 0, write: os.exit()
        stdio = 1, // read: stdin, write: print to stdout
        stderr = 2, // read: 0, write: print to stderr

        scratch_0 = 0x10, // scratch register
        scratch_1 = 0x11, // scratch register
        scratch_2 = 0x12, // scratch register
        scratch_3 = 0x13, // scratch register
        scratch_4 = 0x14, // scratch register
        scratch_5 = 0x15, // scratch register
        scratch_6 = 0x16, // scratch register
        scratch_7 = 0x17, // scratch register
        scratch_8 = 0x18, // scratch register
        scratch_9 = 0x19, // scratch register
        scratch_a = 0x1a, // scratch register
        scratch_b = 0x1b, // scratch register
        scratch_c = 0x1c, // scratch register
        scratch_d = 0x1d, // scratch register
        scratch_e = 0x1e, // scratch register
        scratch_f = 0x1f, // scratch register

        ramp_d = 0x38, // ATmega2560
        ramp_x = 0x39, // ATmega2560
        ramp_y = 0x3A, // ATmega2560
        ramp_z = 0x3B, // ATmega2560
        e_ind = 0x3C, // ATmega2560
        sp_l = 0x3D, // Common
        sp_h = 0x3E, // Common
        sreg = 0x3F, // Common

        _,
    };

    fn read(ctx: ?*anyopaque, addr: aviron.IO.Address) u8 {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        const reg: Register = @enumFromInt(addr);
        return switch (reg) {
            .exit => 0,
            .stdio => if (io.stdin.len > 0) blk: {
                const byte = io.stdin[0];
                io.stdin = io.stdin[1..];
                break :blk byte;
            } else 0xFF, //  EOF
            .stderr => 0,

            .scratch_0 => io.scratch_regs[0x0],
            .scratch_1 => io.scratch_regs[0x1],
            .scratch_2 => io.scratch_regs[0x2],
            .scratch_3 => io.scratch_regs[0x3],
            .scratch_4 => io.scratch_regs[0x4],
            .scratch_5 => io.scratch_regs[0x5],
            .scratch_6 => io.scratch_regs[0x6],
            .scratch_7 => io.scratch_regs[0x7],
            .scratch_8 => io.scratch_regs[0x8],
            .scratch_9 => io.scratch_regs[0x9],
            .scratch_a => io.scratch_regs[0xa],
            .scratch_b => io.scratch_regs[0xb],
            .scratch_c => io.scratch_regs[0xc],
            .scratch_d => io.scratch_regs[0xd],
            .scratch_e => io.scratch_regs[0xe],
            .scratch_f => io.scratch_regs[0xf],

            .sreg => @bitCast(io.sreg.*),

            .ramp_x => io.ramp_x,
            .ramp_y => io.ramp_y,
            .ramp_z => io.ramp_z,
            .ramp_d => io.ramp_d,
            .e_ind => io.e_ind,

            .sp_l => @truncate(io.sp >> 0),
            .sp_h => @truncate(io.sp >> 8),

            _ => blk: {
                // Unimplemented I/O: record an error effect and return 0xFF to the CPU.
                // The CPU will detect this via check_exit and report gracefully.
                break :blk 0xFF;
            },
        };
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    fn write(ctx: ?*anyopaque, addr: aviron.IO.Address, mask: u8, value: u8) void {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        const reg: Register = @enumFromInt(addr);
        switch (reg) {
            .exit => {
                io.exit_requested = true;
                io.exit_code = value & mask;
            },

            .stdio => io.stdout.append(value & mask) catch @panic("out of memory"),
            .stderr => io.stderr.append(value & mask) catch @panic("out of memory"),

            .scratch_0 => write_masked(&io.scratch_regs[0x0], mask, value),
            .scratch_1 => write_masked(&io.scratch_regs[0x1], mask, value),
            .scratch_2 => write_masked(&io.scratch_regs[0x2], mask, value),
            .scratch_3 => write_masked(&io.scratch_regs[0x3], mask, value),
            .scratch_4 => write_masked(&io.scratch_regs[0x4], mask, value),
            .scratch_5 => write_masked(&io.scratch_regs[0x5], mask, value),
            .scratch_6 => write_masked(&io.scratch_regs[0x6], mask, value),
            .scratch_7 => write_masked(&io.scratch_regs[0x7], mask, value),
            .scratch_8 => write_masked(&io.scratch_regs[0x8], mask, value),
            .scratch_9 => write_masked(&io.scratch_regs[0x9], mask, value),
            .scratch_a => write_masked(&io.scratch_regs[0xa], mask, value),
            .scratch_b => write_masked(&io.scratch_regs[0xb], mask, value),
            .scratch_c => write_masked(&io.scratch_regs[0xc], mask, value),
            .scratch_d => write_masked(&io.scratch_regs[0xd], mask, value),
            .scratch_e => write_masked(&io.scratch_regs[0xe], mask, value),
            .scratch_f => write_masked(&io.scratch_regs[0xf], mask, value),

            .ramp_x => write_masked(&io.ramp_x, mask, value),
            .ramp_y => write_masked(&io.ramp_y, mask, value),
            .ramp_z => write_masked(&io.ramp_z, mask, value),
            .ramp_d => write_masked(&io.ramp_d, mask, value),
            .e_ind => write_masked(&io.e_ind, mask, value),

            .sp_l => write_masked(low_byte(&io.sp), mask, value),
            .sp_h => write_masked(high_byte(&io.sp), mask, value),
            .sreg => write_masked(@ptrCast(io.sreg), mask, value),

            _ => {
                // Unimplemented I/O: ignore the write but record an error via stderr to aid debugging.
                // The test harness uses explicit exits, so we do not kill the simulator here.
                std.debug.print("warning: write to undefined I/O register 0x{X} (value=0x{X:0>2}, mask=0x{X:0>2})\n", .{ addr, value, mask });
            },
        }
    }

    fn low_byte(val: *u16) *u8 {
        const bits: *[2]u8 = @ptrCast(val);
        return switch (comptime builtin.cpu.arch.endian()) {
            .big => return &bits[1],
            .little => return &bits[0],
        };
    }

    fn high_byte(val: *u16) *u8 {
        const bits: *[2]u8 = @ptrCast(val);
        return switch (comptime builtin.cpu.arch.endian()) {
            .big => return &bits[0],
            .little => return &bits[1],
        };
    }

    fn write_masked(dst: *u8, mask: u8, val: u8) void {
        dst.* &= ~mask;
        dst.* |= (val & mask);
    }

    fn check_exit(ctx: ?*anyopaque) ?u8 {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        return if (io.exit_requested) io.exit_code else null;
    }
};
