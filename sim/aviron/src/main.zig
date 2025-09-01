const std = @import("std");
const builtin = @import("builtin");
const aviron = @import("aviron");
const args_parser = @import("args");
const ihex = @import("ihex");

pub fn main() !u8 {
    const allocator = std.heap.page_allocator;

    var cli = args_parser.parseForCurrentProcess(Cli, allocator, .print) catch return 1;
    defer cli.deinit();

    if (cli.options.help or (cli.positionals.len == 0 and !cli.options.info)) {
        var stderr_writer = std.fs.File.stderr().writer(&.{});
        try args_parser.printHelp(
            Cli,
            cli.executable_name orelse "aviron",
            &stderr_writer.interface,
        );

        return if (cli.options.help) @as(u8, 0) else 1;
    }

    // Emulate Atmega382p device size:

    // TODO: Add support for more MCUs!
    std.debug.assert(cli.options.mcu == .atmega328p);

    var flash_storage = aviron.Flash.Static(32768){};
    var sram = aviron.RAM.Static(2048){};
    var eeprom = aviron.EEPROM.Static(1024){};
    var io = IO{
        .sreg = undefined,
        .sp = sram.data.len - 1,
    };

    var cpu = aviron.Cpu{
        .trace = cli.options.trace,

        .flash = flash_storage.memory(),
        .sram = sram.memory(),
        .eeprom = eeprom.memory(),
        .io = io.memory(),

        .code_model = .code16,
        .instruction_set = .avr5,

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
    };

    io.sreg = &cpu.sreg;

    if (cli.options.info) {
        var stdout = std.fs.File.stdout().writer(&.{});
        try stdout.interface.print("Information for {s}:\n", .{@tagName(cli.options.mcu)});
        try stdout.interface.print("  Generation: {s: >11}\n", .{@tagName(cpu.instruction_set)});
        try stdout.interface.print("  Code Model: {s: >11}\n", .{@tagName(cpu.code_model)});
        try stdout.interface.print("  Flash:      {d: >5} bytes\n", .{cpu.flash.size});
        try stdout.interface.print("  RAM:        {d: >5} bytes\n", .{cpu.sram.size});
        try stdout.interface.print("  EEPROM:     {d: >5} bytes\n", .{cpu.eeprom.size});
        try stdout.interface.flush();
        return 0;
    }

    // Load all provided executables:
    for (cli.positionals) |file_path| {
        var file = try std.fs.cwd().openFile(file_path, .{});
        defer file.close();

        var file_buf: [4096]u8 = undefined;
        var reader = file.reader(&file_buf);

        switch (cli.options.format) {
            .elf => {
                var header = try std.elf.Header.read(&reader.interface);

                var pheaders = header.iterateProgramHeaders(&reader);
                while (try pheaders.next()) |phdr| {
                    if (phdr.p_type != std.elf.PT_LOAD)
                        continue; // Header isn't lodead

                    const dest_mem = if (phdr.p_paddr >= 0x0080_0000)
                        &sram.data
                    else
                        &flash_storage.data;

                    const addr_masked: u24 = @intCast(phdr.p_paddr & 0x007F_FFFF);

                    try reader.seekTo(phdr.p_offset);
                    try reader.interface.readSliceAll(dest_mem[addr_masked..][0..phdr.p_filesz]);
                    @memset(dest_mem[addr_masked + phdr.p_filesz ..][0 .. phdr.p_memsz - phdr.p_filesz], 0);
                }
            },
            .binary, .bin => {
                const size = try file.readAll(&flash_storage.data);
                @memset(flash_storage.data[size..], 0);
            },
            .ihex, .hex => {
                const ihex_processor = struct {
                    fn process(flash: *@TypeOf(flash_storage), offset: u32, data: []const u8) !void {
                        @memcpy(flash.data[offset .. offset + data.len], data);
                    }
                };
                _ = try ihex.parseData(&reader.interface, .{ .pedantic = true }, &flash_storage, anyerror, ihex_processor.process);
            },
        }
    }

    const result = try cpu.run(null);

    std.debug.print("STOP: {s}\n", .{@tagName(result)});

    return 0;
}

// not actually marvel cinematic universe, but microcontroller unit ;
pub const MCU = enum {
    atmega328p,
};

pub const FileFormat = enum {
    elf,
    bin,
    binary,
    ihex,
    hex,
};

const Cli = struct {
    help: bool = false,
    trace: bool = false,
    mcu: MCU = .atmega328p,
    info: bool = false,
    format: FileFormat = .elf,

    pub const shorthands = .{
        .h = "help",
        .t = "trace",
        .m = "mcu",
        .I = "info",
        .f = "format",
    };
    pub const meta = .{
        .summary = "[-h] [-t] [-m <mcu>] <file> ...",
        .full_text =
        \\AViRon is a simulator for the AVR cpu architecture as well as an basic emulator for several microcontrollers from Microchip/Atmel.
        \\
        \\Loads at least a single <elf> file into the memory of the system and executes it with the provided MCU.
        \\
        \\The code can use certain special registers to perform I/O and exit the emulator.
        ,
        .option_docs = .{
            .help = "Prints this help text.",
            .trace = "Trace all executed instructions.",
            .mcu = "Selects the emulated MCU.",
            .info = "Prints information about the given MCUs memory.",
            .format = "Specify file format.",
        },
    };
};

const IO = struct {
    scratch_regs: [16]u8 = @splat(0),

    sp: u16,
    sreg: *aviron.Cpu.SREG,

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
            .stdio => blk: {
                var stdin = std.fs.File.stdin().reader(&.{});
                var buf: [1]u8 = undefined;
                stdin.interface.readSliceAll(&buf) catch break :blk 0xFF; // 0xFF = EOF
                break :blk buf[0];
            },
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
            .exit => std.process.exit(value & mask),
            .stdio => {
                var stdout = std.fs.File.stdout().writer(&.{});
                stdout.interface.writeByte(value & mask) catch @panic("i/o failure");
            },
            .stderr => {
                var stderr = std.fs.File.stderr().writer(&.{});
                stderr.interface.writeByte(value & mask) catch @panic("i/o failure");
            },

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
