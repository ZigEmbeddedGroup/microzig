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

const SystemState = struct {
    cpu: aviron.Cpu,

    // Emulate Atmega382p device size:
    flash_storage: aviron.Flash.Static(32768) = .{},
    sram: aviron.RAM.Static(2048) = .{},
    eeprom: aviron.EEPROM.Static(1024) = .{},
    io: IO,

    config: testconfig.TestSuiteConfig,
    options: Cli,
};

var test_system: SystemState = undefined;

const ExitMode = union(testconfig.ExitType) {
    breakpoint,
    enter_sleep_mode,
    reset_watchdog,
    out_of_gas,
    system_exit: u8,
};

fn validate_reg(ok: *bool, ts: *SystemState, comptime reg: aviron.Register) void {
    const expected = @field(ts.config.postcondition, @tagName(reg)) orelse return;

    const actual = ts.cpu.regs[reg.num()];
    if (expected != actual) {
        std.debug.print("Invalid register value for register {s}: Expected {}, but got {}.\n", .{
            @tagName(reg),
            expected,
            actual,
        });
        ok.* = false;
    }
}

fn validate_syste_and_exit(exit_mode: ExitMode) noreturn {
    var ok = true;
    const ts = &test_system;

    if (exit_mode != ts.config.exit) {
        std.debug.print("Invalid exit type: Expected {s}, but got {s}.\n", .{
            @tagName(ts.config.exit),
            @tagName(exit_mode),
        });
        ok = false;
    } else if (exit_mode == .system_exit and exit_mode.system_exit != ts.config.exit_code) {
        std.debug.print("Invalid exit code: Expected {}, but got {}.\n", .{
            ts.config.exit_code,
            exit_mode.system_exit,
        });
        ok = false;
    }

    if (!std.mem.eql(u8, ts.io.stdout.items, ts.config.stdout)) {
        std.debug.print("stdout mismatch:\n", .{});
        std.debug.print("expected: '{x}'\n", .{ts.config.stdout});
        std.debug.print("actual:   '{x}'\n", .{ts.io.stdout.items});
        ok = false;
    }

    if (!std.mem.eql(u8, ts.io.stderr.items, ts.config.stderr)) {
        std.debug.print("stderr mismatch:\n", .{});
        std.debug.print("expected: '{x}'\n", .{ts.config.stderr});
        std.debug.print("actual:   '{x}'\n", .{ts.io.stderr.items});
        ok = false;
    }

    inline for (comptime std.enums.values(aviron.Register)) |reg| {
        validate_reg(&ok, ts, reg);
    }

    inline for (comptime std.meta.fields(aviron.Cpu.SREG)) |fld| {
        if (@field(test_system.config.postcondition.sreg, fld.name)) |expected_value| {
            const actual_value = @field(test_system.cpu.sreg, fld.name);
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

    if (!ok and ts.options.name.len > 0) {
        std.debug.print("test {s} failed.\n", .{ts.options.name});
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

    var stdout = std.array_list.Managed(u8).init(allocator);
    defer stdout.deinit();

    var stderr = std.array_list.Managed(u8).init(allocator);
    defer stderr.deinit();

    test_system = SystemState{
        .options = cli.options,
        .config = config,

        .io = IO{
            .sreg = &test_system.cpu.sreg,
            // Initialize SP to RAMEND (0x0100 + SRAM size - 1)
            .sp = @as(u16, 0x0100) + @as(u16, test_system.sram.data.len - 1),
            .config = config,

            .stdin = config.stdin,
            .stdout = &stdout,
            .stderr = &stderr,
        },

        .cpu = aviron.Cpu{
            .trace = cli.options.trace,

            .instruction_set = .avr5,

            .flash = test_system.flash_storage.memory(),
            .sram = test_system.sram.memory(),
            .eeprom = test_system.eeprom.memory(),
            .io = test_system.io.memory(),

            .code_model = .code16,

            .sio = .{
                .ramp_x = null,
                .ramp_y = null,
                .ramp_z = null,
                .ramp_d = null,
                .e_ind = null,

                .sp_l = @intFromEnum(IO.Register.sp_l),
                .sp_h = @intFromEnum(IO.Register.sp_h),

                .sreg = @intFromEnum(IO.Register.sreg),
            },
        },
    };

    // Initialize CPU state:
    inline for (comptime std.meta.fields(aviron.Cpu.SREG)) |fld| {
        if (@field(test_system.config.precondition.sreg, fld.name)) |init_value| {
            @field(test_system.cpu.sreg, fld.name) = init_value;
        }
    }
    inline for (comptime std.enums.values(aviron.Register)) |reg| {
        if (@field(test_system.config.precondition, @tagName(reg))) |init_value| {
            test_system.cpu.regs[reg.num()] = init_value;
        }
    }

    for (cli.positionals) |file_path| {
        var elf_file = try std.fs.cwd().openFile(file_path, .{});
        defer elf_file.close();

        var buf: [4096]u8 = undefined;
        var file_reader = elf_file.reader(&buf);

        var header = try std.elf.Header.read(&file_reader.interface);

        var pheaders = header.iterateProgramHeaders(&file_reader);
        while (try pheaders.next()) |phdr| {
            if (phdr.p_type != std.elf.PT_LOAD)
                continue; // Header isn't lodead

            const dest_mem = if (phdr.p_vaddr >= 0x0080_0000)
                &test_system.sram.data
            else
                &test_system.flash_storage.data;

            const addr_masked: u24 = @intCast(phdr.p_vaddr & 0x007F_FFFF);

            if (phdr.p_filesz > 0) {
                try file_reader.seekTo(phdr.p_offset);
                try file_reader.interface.readSliceAll(dest_mem[addr_masked..][0..phdr.p_filesz]);
            }
            if (phdr.p_memsz > phdr.p_filesz) {
                @memset(dest_mem[addr_masked + phdr.p_filesz ..][0 .. phdr.p_memsz - phdr.p_filesz], 0);
            }
        }
    }

    const result = try test_system.cpu.run(null);
    validate_syste_and_exit(switch (result) {
        inline else => |tag| @unionInit(ExitMode, @tagName(tag), {}),
    });
}

const IO = struct {
    config: testconfig.TestSuiteConfig,

    scratch_regs: [16]u8 = @splat(0),

    sp: u16,
    sreg: *aviron.Cpu.SREG,

    stdout: *std.array_list.Managed(u8),
    stderr: *std.array_list.Managed(u8),

    stdin: []const u8,

    pub fn memory(self: *IO) aviron.IO {
        return aviron.IO{
            .ctx = self,
            .vtable = &vtable,
        };
    }

    pub const vtable = aviron.IO.VTable{
        .readFn = read,
        .writeFn = write,
    };

    // This is our own "debug" device with it's own debug addresses:
    const Register = enum(u6) {
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

        sp_l = 0x3D, // ATmega328p
        sp_h = 0x3E, // ATmega328p
        sreg = 0x3F, // ATmega328p

        _,
    };

    fn read(ctx: ?*anyopaque, addr: u6) u8 {
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

            .sp_l => @truncate(io.sp >> 0),
            .sp_h => @truncate(io.sp >> 8),

            _ => std.debug.panic("illegal i/o read from undefined register 0x{X:0>2}", .{addr}),
        };
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    fn write(ctx: ?*anyopaque, addr: u6, mask: u8, value: u8) void {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        const reg: Register = @enumFromInt(addr);
        switch (reg) {
            .exit => validate_syste_and_exit(.{
                .system_exit = (value & mask),
            }),

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

            .sp_l => write_masked(low_byte(&io.sp), mask, value),
            .sp_h => write_masked(high_byte(&io.sp), mask, value),
            .sreg => write_masked(@ptrCast(io.sreg), mask, value),

            _ => std.debug.panic("illegal i/o write to undefined register 0x{X:0>2} with value=0x{X:0>2}, mask=0x{X:0>2}", .{ addr, value, mask }),
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
};
