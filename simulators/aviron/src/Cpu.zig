const std = @import("std");
const isa = @import("isa.zig");

const Cpu = @This();

pc: u24 = 0,
gp_registers: [32]u8 = [1]u8{0} ** 32,
st_registers: StatusRegisters.Map = StatusRegisters.Map.initEmpty(),

flash: Flash,
sram: RAM,
eeprom: EEPROM,
io: IO,

pub fn getIndirectAddressRegister(cpu: *Cpu, which: enum { x, y, z }) *u16 {
    return @ptrCast(cpu.gp_registers[26 + @intFromEnum(which) * 2][0..2]);
}

pub fn shiftProgramCounter(cpu: *Cpu, by: i12) void {
    cpu.pc = @intCast(@as(i32, @intCast(cpu.pc)) + by);
}

pub fn run(cpu: *Cpu) !void {
    while (true) : (cpu.pc += 1) {
        const inst = isa.decode(cpu.flash.read(cpu.pc)) catch break;

        switch (inst) {
            inline else => |value| std.log.info(" {s} {}", .{ @tagName(inst), value }),
        }

        switch (inst) {
            .movw,
            .muls,
            .nop,
            .mulsu,
            .fmul,
            .fmuls,
            .fmulsu,
            => {},
            .cpc => |bits| {
                const rd = cpu.gp_registers[bits.d];
                const rr = cpu.gp_registers[bits.r];

                if (rr == rd)
                    cpu.st_registers.setPresent(.z, false);

                const result: u8 = @intFromBool(rr == rd);

                // carry & half carry
                const sub_carry: u8 = (~rd & rr) | (rr & result) | (result & ~rd);
                cpu.st_registers.setPresent(.h, (sub_carry >> 3) & 1 != 0);
                cpu.st_registers.setPresent(.c, (sub_carry >> 7) & 1 != 0);

                // overflow
                cpu.st_registers.setPresent(.v, (((rd & ~rr & ~result) | (~rd & rr & result)) >> 7) & 1 != 0);

                if (result == 1)
                    cpu.st_registers.setPresent(.z, false);
                cpu.st_registers.setPresent(.n, (result >> 7) & 1 != 0);
                cpu.st_registers.setPresent(.s, @intFromBool(cpu.st_registers.contains(.n)) ^ @intFromBool(cpu.st_registers.contains(.v)) != 0);
            },
            .sbc,
            .add,
            .cpse,
            .cp,
            .sub,
            .adc,
            .@"and",
            .eor,
            .@"or",
            .mov,
            => {},
            .cpi => |bits| {
                const register = @as(u6, bits.d) + 16;
                if (!(16 <= register and register <= 31))
                    return error.InvalidInstruction;

                const result: u8 = @intFromBool(bits.k == cpu.gp_registers[register]);

                // carry & half carry
                const sub_carry: u8 = (~register & bits.k) | (bits.k & result) | (result & ~register);
                cpu.st_registers.setPresent(.h, (sub_carry >> 3) & 1 != 0);
                cpu.st_registers.setPresent(.c, (sub_carry >> 7) & 1 != 0);

                // overflow
                cpu.st_registers.setPresent(.v, (((register & ~bits.k & ~result) | (~register & bits.k & result)) >> 7) & 1 != 0);

                cpu.st_registers.setPresent(.z, result == 0);
                cpu.st_registers.setPresent(.n, (result >> 7) & 1 != 0);
                cpu.st_registers.setPresent(.s, @intFromBool(cpu.st_registers.contains(.n)) ^ @intFromBool(cpu.st_registers.contains(.v)) != 0);
            },
            .sbci,
            .subi,
            .ori,
            .andi,
            .lds,
            .ldz_ii,
            .ldz_iii,
            .lpm_ii,
            .lpm_iii,
            .elpm_ii,
            .elpm_iii,
            .ldy_ii,
            .ldy_iii,
            .ldx_i,
            .ldx_ii,
            .ldx_iii,
            .pop,
            .sts,
            .push,
            .stz_ii,
            .stz_iii,
            .xch,
            .las,
            .lac,
            .lat,
            .sty_ii,
            .sty_iii,
            .stx_i,
            .stx_ii,
            .stx_iii,
            .ijmp,
            .eijmp,
            .bset,
            .bclr,
            .des,
            .ret,
            .icall,
            .reti,
            .eicall,
            .sleep,
            .wdr,
            .lpm_i,
            .elpm_i,
            .spm_i,
            .spm_ii,
            .com,
            .neg,
            .swap,
            .inc,
            .asr,
            .lsr,
            .ror,
            .dec,
            .jmp,
            .call,
            .adiw,
            .sbiw,
            .cbi,
            .sbic,
            .sbi,
            .sbis,
            .mul,
            .in,
            .out,
            .ldz_iv,
            .ldy_iv,
            .stz_iv,
            .sty_iv,
            .rcall,
            => {},
            .ldi => |bits| {
                const register = @as(u6, bits.d) + 16;
                if (!(16 <= register and register <= 31))
                    return error.InvalidInstruction;

                cpu.gp_registers[register] = bits.k;
            },
            .brbs => |bits| {
                const pc_offset: i7 = @bitCast(bits.k);
                if (cpu.st_registers.contains(@enumFromInt(bits.s))) {
                    cpu.shiftProgramCounter(pc_offset);
                }
            },
            .brbc => |bits| {
                const pc_offset: i7 = @bitCast(bits.k);
                if (!cpu.st_registers.contains(@enumFromInt(bits.s))) {
                    cpu.shiftProgramCounter(pc_offset);
                }
            },
            .bld,
            .bst,
            .sbrc,
            .sbrs,
            => {},
            .rjmp => |bits| {
                if (@as(i12, @bitCast(bits.k)) == -1) {
                    std.log.info("this is a while(true)... exiting now", .{});
                    return;
                }
                cpu.shiftProgramCounter(@as(i12, @bitCast(bits.k)));
            },

            .unknown => return error.InvalidInstruction,
        }
    }
}

pub const Flash = struct {
    ctx: ?*anyopaque,
    vtable: *const VTable,
    size: usize,

    pub fn read(mem: Flash, addr: u24) u16 {
        std.debug.assert(addr < mem.size);
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: u24) u16,
    };

    pub const empty = Flash{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = emptyRead },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u24) u16 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    pub fn Static(comptime size: comptime_int) type {
        if ((size & 1) != 0)
            @compileError("size must be a multiple of two!");
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,

            pub fn memory(self: *Self) Flash {
                return Flash{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = @divExact(size, 2),
                };
            }

            pub const vtable = VTable{ .readFn = memRead };

            fn memRead(ctx: ?*anyopaque, addr: u24) u16 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return std.mem.bytesAsSlice(u16, &mem.data)[addr];
            }
        };
    }
};

pub const RAM = struct {
    ctx: ?*anyopaque,
    vtable: *const VTable,
    size: usize,

    pub fn read(mem: RAM, addr: u16) u8 {
        std.debug.assert(addr < mem.size);
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub fn write(mem: RAM, addr: u16, value: u8) void {
        std.debug.assert(addr < mem.size);
        return mem.vtable.writeFn(mem.ctx, addr, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: u16) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: u16, value: u8) void,
    };

    pub const empty = RAM{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = emptyRead, .writeFn = emptyWrite },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u16) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn emptyWrite(ctx: ?*anyopaque, addr: u16, value: u8) void {
        _ = value;
        _ = addr;
        _ = ctx;
    }

    pub fn Static(comptime size: comptime_int) type {
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,

            pub fn memory(self: *Self) RAM {
                return RAM{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = @divExact(size, 2),
                };
            }

            pub const vtable = VTable{
                .readFn = memRead,
                .writeFn = memWrite,
            };

            fn memRead(ctx: ?*anyopaque, addr: u16) u8 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return mem.data[addr];
            }

            fn memWrite(ctx: ?*anyopaque, addr: u16, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                mem.data[addr] = value;
            }
        };
    }
};

pub const EEPROM = RAM; // actually the same interface *shrug*

pub const IO = struct {
    ctx: ?*anyopaque,
    vtable: *const VTable,

    pub fn read(mem: IO, addr: u5) u8 {
        std.debug.assert(addr < mem.size);
        return mem.vtable.readFn(mem.ctx, addr);
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    pub fn write(mem: IO, addr: u5, mask: u8, value: u8) void {
        std.debug.assert(addr < mem.size);
        return mem.vtable.writeFn(mem.ctx, addr, mask, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: u5) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: u5, mask: u8, value: u8) void,
    };

    pub const empty = IO{
        .ctx = null,
        .vtable = &VTable{ .readFn = emptyRead, .writeFn = emptyWrite },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u5) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn emptyWrite(ctx: ?*anyopaque, addr: u5, mask: u8, value: u8) void {
        _ = mask;
        _ = value;
        _ = addr;
        _ = ctx;
    }
};

pub const StatusRegisters = enum(u8) {
    const Map = std.enums.EnumSet(@This());

    /// Carry Flag
    c,
    /// Zero Flag
    z,
    /// Negative Flag
    n,
    /// Two's Compliment Overflow Flag
    v,
    /// Sign Flag, S = N xor V
    s,
    /// Half Carry Flag
    h,
    /// Copy Storage
    t,
    /// Global Interrupt Enable
    i,
};
