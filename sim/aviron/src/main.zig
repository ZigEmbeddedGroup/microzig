const std = @import("std");
const builtin = @import("builtin");
const aviron = @import("aviron");
const ihex = @import("ihex");
const flags = @import("flags");

const RunWith_MCU_Options = struct {
    trace: bool = false,
    info: bool = false,
    format: FileFormat = .elf,
    gas: ?u64 = null,
    breakpoint: ?u24 = null,
};

fn run_with_mcu(
    gpa: std.mem.Allocator,
    io: std.Io,
    comptime mcu_config: aviron.mcu.Config,
    positionals: []const []const u8,
    options: RunWith_MCU_Options,
) !u8 {
    // Allocate memory based on MCU configuration
    var flash_storage: aviron.Flash.Static(mcu_config.flash_size) = .{};
    var sram = aviron.FixedSizeMemory(mcu_config.sram_size, .{ .address_type = u24 }){};
    // TODO: Add support for reading/writing EEPROM through IO

    var bus_io = IO{
        .io = io,
        .sreg = undefined,
        .sp = mcu_config.sram_base + mcu_config.sram_size - 1,
    };

    // Create memory interfaces
    const flash_mem = flash_storage.memory();

    // Build Bus interfaces
    const io_data_bus = bus_io.bus(); // For memory-mapped data space
    const io_io_bus = bus_io.io_bus(); // For direct IO operations
    const sram_bus = sram.bus();

    var spaces = try aviron.mcu.build_spaces(gpa, mcu_config, sram_bus, io_data_bus);
    defer spaces.deinit(gpa);

    var cpu = aviron.Cpu{
        .trace = options.trace,

        .flash = flash_mem,
        .data = spaces.data.bus(),
        .io = io_io_bus,

        .code_model = mcu_config.code_model,
        .instruction_set = mcu_config.instruction_set,
        .sram_base = mcu_config.sram_base,
        .sram_size = mcu_config.sram_size,

        .sio = mcu_config.special_io,
    };

    bus_io.sreg = &cpu.sreg;

    if (options.info) {
        var stdout = std.Io.File.stdout().writer(io, &.{});
        try stdout.interface.print("Information for {s}:\n", .{mcu_config.name});
        try stdout.interface.print("  Generation: {s: >11}\n", .{@tagName(cpu.instruction_set)});
        try stdout.interface.print("  Code Model: {s: >11}\n", .{@tagName(cpu.code_model)});
        try stdout.interface.print("  Flash:      {d: >5} bytes\n", .{cpu.flash.size});
        try stdout.interface.print("  RAM:        {d: >5} bytes\n", .{mcu_config.sram_size});
        try stdout.interface.print("  EEPROM:     {d: >5} bytes\n", .{mcu_config.eeprom_size});
        try stdout.interface.flush();
        return 0;
    }

    // Load all provided executables:
    for (positionals) |file_path| {
        var file = try std.Io.Dir.cwd().openFile(io, file_path, .{});
        defer file.close(io);

        var file_buf: [4096]u8 = undefined;
        var reader = file.reader(io, &file_buf);
        switch (options.format) {
            .elf => {
                var header = try std.elf.Header.read(&reader.interface);

                // Set PC to entry point (convert byte address to word address for AVR)
                cpu.pc = @intCast(header.entry / 2);

                // Get the data bus for loading segments
                const data_bus = spaces.data.bus();

                var pheaders = header.iterateProgramHeaders(&reader);
                while (try pheaders.next()) |phdr| {
                    if (phdr.p_type != std.elf.PT_LOAD)
                        continue; // Header isn't loaded

                    if (phdr.p_memsz == 0)
                        continue; // Empty segment, nothing to load

                    // Use vaddr to determine if this is data or code
                    // AVR uses 0x800000 flag in vaddr to indicate data memory
                    const is_data = phdr.p_vaddr >= 0x0080_0000;
                    const target_addr: u24 = @intCast(phdr.p_vaddr & 0x007F_FFFF);

                    try reader.seekTo(phdr.p_offset);

                    if (is_data) {
                        // Load data segment via Bus interface
                        // Use a stack buffer to read and write through the bus
                        var read_buf: [256]u8 = undefined;
                        var remaining = phdr.p_filesz;
                        var offset: usize = 0;
                        while (remaining > 0) {
                            const to_read = @min(remaining, read_buf.len);
                            try reader.interface.readSliceAll(read_buf[0..to_read]);
                            for (read_buf[0..to_read], 0..) |byte, i| {
                                try data_bus.write(@intCast(target_addr + offset + i), byte);
                            }
                            offset += to_read;
                            remaining -= to_read;
                        }

                        // Zero-fill the remaining memory
                        var i: usize = phdr.p_filesz;
                        while (i < phdr.p_memsz) : (i += 1) {
                            try data_bus.write(@intCast(target_addr + i), 0);
                        }
                    } else {
                        // Flash can be loaded directly
                        try reader.interface.readSliceAll(flash_storage.data[target_addr..][0..phdr.p_filesz]);
                        @memset(flash_storage.data[target_addr + phdr.p_filesz ..][0 .. phdr.p_memsz - phdr.p_filesz], 0);
                    }
                }
            },
            .binary, .bin => {
                const size = try reader.interface.readSliceShort(&flash_storage.data);
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

    const result = try cpu.run(options.gas, options.breakpoint);
    if (options.trace) {
        cpu.dump_system_state();
    }

    std.debug.print("\nSTOP: {s}\n", .{@tagName(result)});
    if (result == .program_exit) {
        return bus_io.exit_code.?;
    }

    return 0;
}

const CLI_Args = struct {
    help: bool = false,
    trace: bool = false,
    mcu: MCU = .atmega328p,
    info: bool = false,
    format: FileFormat = .elf,
    breakpoint: ?u24 = null,
    gas: ?u64 = null,

    pub const default: CLI_Args = .{};

    const usage =
        \\[--help] [--trace] [--mcu=<value>] [--info] [--format=<value>] [--breakpoint=<value>] [--gas=<value>] <file> ...
        \\
        \\AViRon is a simulator for the AVR cpu architecture as well as an basic emulator for several microcontrollers from Microchip/Atmel.
        \\
        \\Loads at least a single <elf> file into the memory of the system and executes it with the provided MCU.
        \\
        \\The code can use certain special registers to perform I/O and exit the emulator.
        \\
        \\It accepts the following arguments:
        \\
        \\--help
        \\--trace
        \\--info
        \\--mcu=<value>
        \\--format=<value>
        \\--breakpoint=<value>
        \\--gas=<value>
        \\
    ;
};

pub fn main(init: std.process.Init) !u8 {
    const gpa = init.gpa;
    const args = try init.minimal.args.toSlice(init.arena.allocator());
    const cli_args, const positionals = try flags.parse(CLI_Args, init.arena.allocator(), args);

    const io = init.io;
    if (cli_args.help) {
        var stdout = std.Io.File.stdout().writer(io, &.{});
        try stdout.interface.print("{s}", .{CLI_Args.usage});
        try stdout.interface.flush();
        return 0;
    }

    const options: RunWith_MCU_Options = .{
        .trace = cli_args.trace,
        .info = cli_args.info,
        .format = cli_args.format,
        .gas = cli_args.gas,
        .breakpoint = cli_args.breakpoint,
    };

    return switch (cli_args.mcu) {
        .atmega328p => try run_with_mcu(gpa, io, aviron.mcu.atmega328p, positionals, options),
        .attiny816 => try run_with_mcu(gpa, io, aviron.mcu.attiny816, positionals, options),
        .atmega2560 => try run_with_mcu(gpa, io, aviron.mcu.atmega2560, positionals, options),
        .xmega128a4u => try run_with_mcu(gpa, io, aviron.mcu.xmega128a4u, positionals, options),
    };
}

// not actually marvel cinematic universe, but microcontroller unit ;
pub const MCU = enum {
    atmega328p,
    attiny816,
    atmega2560,
    xmega128a4u,
};

pub const FileFormat = enum {
    elf,
    bin,
    binary,
    ihex,
    hex,
};

const IO = struct {
    io: std.Io,
    scratch_regs: [16]u8 = @splat(0),

    sp: u16,
    sreg: *aviron.Cpu.SREG,

    // RAMP registers for extended addressing (used by larger MCUs like ATmega2560)
    ramp_x: u8 = 0,
    ramp_y: u8 = 0,
    ramp_z: u8 = 0,
    ramp_d: u8 = 0,
    e_ind: u8 = 0,

    // Exit status tracking
    exit_code: ?u8 = null,

    const aviron_module = @import("aviron");
    const IOBusType = aviron_module.IOBus;
    const DataBusType = aviron_module.Bus(.{ .address_type = u24 });

    pub fn bus(self: *IO) DataBusType {
        return .{ .ctx = self, .vtable = &data_bus_vtable };
    }

    pub fn io_bus(self: *IO) IOBusType {
        return .{ .ctx = self, .vtable = &io_bus_vtable };
    }

    const data_bus_vtable = DataBusType.VTable{
        .read = dev_read_data,
        .write = dev_write_data,
        .check_exit = dev_check_exit,
    };

    const io_bus_vtable = IOBusType.VTable{
        .read = dev_read,
        .write = dev_write_masked,
        .check_exit = dev_check_exit,
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

        // Extended addressing registers (ATmega2560 and similar)
        ramp_d = 0x38, // ATmega2560
        ramp_x = 0x39, // ATmega2560
        ramp_y = 0x3A, // ATmega2560
        ramp_z = 0x3B, // ATmega2560
        e_ind = 0x3C, // ATmega2560

        // Common registers
        sp_l = 0x3D, // Common
        sp_h = 0x3E, // Common
        sreg = 0x3F, // Common

        _,
    };

    fn dev_read_data(ctx: *anyopaque, addr: DataBusType.Address) DataBusType.Error!u8 {
        return dev_read(ctx, @intCast(addr));
    }

    fn dev_read(ctx: *anyopaque, addr: IOBusType.Address) u8 {
        const bus_io: *IO = @ptrCast(@alignCast(ctx));
        const reg: Register = @enumFromInt(@as(aviron.IO.Address, @intCast(addr)));
        return switch (reg) {
            .exit => 0,
            .stdio => blk: {
                var stdin = std.Io.File.stdin().reader(bus_io.io, &.{});
                var buf: [1]u8 = undefined;
                stdin.interface.readSliceAll(&buf) catch break :blk 0xFF; // 0xFF = EOF
                break :blk buf[0];
            },
            .stderr => 0,

            .scratch_0 => bus_io.scratch_regs[0x0],
            .scratch_1 => bus_io.scratch_regs[0x1],
            .scratch_2 => bus_io.scratch_regs[0x2],
            .scratch_3 => bus_io.scratch_regs[0x3],
            .scratch_4 => bus_io.scratch_regs[0x4],
            .scratch_5 => bus_io.scratch_regs[0x5],
            .scratch_6 => bus_io.scratch_regs[0x6],
            .scratch_7 => bus_io.scratch_regs[0x7],
            .scratch_8 => bus_io.scratch_regs[0x8],
            .scratch_9 => bus_io.scratch_regs[0x9],
            .scratch_a => bus_io.scratch_regs[0xa],
            .scratch_b => bus_io.scratch_regs[0xb],
            .scratch_c => bus_io.scratch_regs[0xc],
            .scratch_d => bus_io.scratch_regs[0xd],
            .scratch_e => bus_io.scratch_regs[0xe],
            .scratch_f => bus_io.scratch_regs[0xf],

            .sreg => @bitCast(bus_io.sreg.*),

            .ramp_x => bus_io.ramp_x,
            .ramp_y => bus_io.ramp_y,
            .ramp_z => bus_io.ramp_z,
            .ramp_d => bus_io.ramp_d,
            .e_ind => bus_io.e_ind,

            .sp_l => @truncate(bus_io.sp >> 0),
            .sp_h => @truncate(bus_io.sp >> 8),

            _ => std.debug.panic("illegal i/o read from undefined register 0x{X:0>2}", .{addr}),
        };
    }

    fn dev_write_data(ctx: *anyopaque, addr: DataBusType.Address, value: u8) DataBusType.Error!void {
        // Data bus writes full bytes (mask = 0xFF)
        dev_write_masked(ctx, @intCast(addr), 0xFF, value);
    }

    fn dev_write_masked(ctx: *anyopaque, addr: IOBusType.Address, mask: u8, value: u8) void {
        const bus_io: *IO = @ptrCast(@alignCast(ctx));
        const reg: Register = @enumFromInt(@as(aviron.IO.Address, @intCast(addr)));
        switch (reg) {
            .exit => {
                bus_io.exit_code = value & mask;
            },
            .stdio => {
                var stdout = std.Io.File.stdout().writer(bus_io.io, &.{});
                stdout.interface.writeByte(value & mask) catch @panic("i/o failure");
            },
            .stderr => {
                var stderr = std.Io.File.stderr().writer(bus_io.io, &.{});
                stderr.interface.writeByte(value & mask) catch @panic("i/o failure");
            },

            .scratch_0 => write_masked(&bus_io.scratch_regs[0x0], mask, value),
            .scratch_1 => write_masked(&bus_io.scratch_regs[0x1], mask, value),
            .scratch_2 => write_masked(&bus_io.scratch_regs[0x2], mask, value),
            .scratch_3 => write_masked(&bus_io.scratch_regs[0x3], mask, value),
            .scratch_4 => write_masked(&bus_io.scratch_regs[0x4], mask, value),
            .scratch_5 => write_masked(&bus_io.scratch_regs[0x5], mask, value),
            .scratch_6 => write_masked(&bus_io.scratch_regs[0x6], mask, value),
            .scratch_7 => write_masked(&bus_io.scratch_regs[0x7], mask, value),
            .scratch_8 => write_masked(&bus_io.scratch_regs[0x8], mask, value),
            .scratch_9 => write_masked(&bus_io.scratch_regs[0x9], mask, value),
            .scratch_a => write_masked(&bus_io.scratch_regs[0xa], mask, value),
            .scratch_b => write_masked(&bus_io.scratch_regs[0xb], mask, value),
            .scratch_c => write_masked(&bus_io.scratch_regs[0xc], mask, value),
            .scratch_d => write_masked(&bus_io.scratch_regs[0xd], mask, value),
            .scratch_e => write_masked(&bus_io.scratch_regs[0xe], mask, value),
            .scratch_f => write_masked(&bus_io.scratch_regs[0xf], mask, value),

            .sp_l => write_masked(low_byte(&bus_io.sp), mask, value),
            .sp_h => write_masked(high_byte(&bus_io.sp), mask, value),
            .sreg => write_masked(@ptrCast(bus_io.sreg), mask, value),

            .ramp_x => write_masked(&bus_io.ramp_x, mask, value),
            .ramp_y => write_masked(&bus_io.ramp_y, mask, value),
            .ramp_z => write_masked(&bus_io.ramp_z, mask, value),
            .ramp_d => write_masked(&bus_io.ramp_d, mask, value),
            .e_ind => write_masked(&bus_io.e_ind, mask, value),

            _ => std.debug.panic(
                "illegal i/o write to undefined register 0x{X:0>2} with value=0x{X:0>2}, mask=0x{X:0>2}",
                .{ addr, value, mask },
            ),
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

    fn dev_check_exit(ctx: *anyopaque) ?u8 {
        const bus_io: *IO = @ptrCast(@alignCast(ctx));
        if (bus_io.exit_code) |code| {
            return code;
        }
        return null;
    }
};
