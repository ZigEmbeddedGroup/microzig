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

pub fn run(cpu: *Cpu, mileage: ?u64) !void {
    var rest_gas = mileage;

    while ((rest_gas orelse 1) > 0) : (cpu.pc += 1) {
        if (rest_gas) |*rg| {
            rg.* -= 1;
        }

        const inst = isa.decode(cpu.flash.read(cpu.pc)) catch break;

        // switch (inst) {
        //     inline else => |value| std.log.info(" {s} {}", .{ @tagName(inst), value }),
        // }

        switch (std.meta.activeTag(inst)) {
            .unknown => return error.InvalidInstruction,
            inline else => |tag| @field(instructions, @tagName(tag))(cpu, @field(inst, @tagName(tag))),
        }
    }
}

fn InfoType(comptime instr: isa.Opcode) type {
    return std.meta.fieldInfo(isa.Instruction, instr).type;
}

fn regBase16(r: u5) u6 {
    return @as(u6, r) | 0x10;
}

const instructions = struct {
    // Copy:

    inline fn mov(cpu: *Cpu, info: InfoType(.mov)) void {
        _ = cpu;
        std.debug.print("mov {}\n", .{info});
        @panic("mov not implemented yet!");
    }

    inline fn movw(cpu: *Cpu, info: InfoType(.movw)) void {
        _ = cpu;
        std.debug.print("movw {}\n", .{info});
        @panic("movw not implemented yet!");
    }

    inline fn xch(cpu: *Cpu, info: InfoType(.xch)) void {
        _ = cpu;
        std.debug.print("xch {}\n", .{info});
        @panic("xch not implemented yet!");
    }

    inline fn swap(cpu: *Cpu, info: InfoType(.swap)) void {
        _ = cpu;
        std.debug.print("swap {}\n", .{info});
        @panic("swap not implemented yet!");
    }

    // ALU Bitwise:
    inline fn com(cpu: *Cpu, info: InfoType(.com)) void {
        _ = cpu;
        std.debug.print("com {}\n", .{info});
        @panic("com not implemented yet!");
    }

    inline fn @"and"(cpu: *Cpu, info: InfoType(.@"and")) void {
        cpu.gp_registers[info.d] = cpu.gp_registers[info.d] & cpu.gp_registers[info.r];
    }

    inline fn eor(cpu: *Cpu, info: InfoType(.eor)) void {
        cpu.gp_registers[info.d] = cpu.gp_registers[info.d] ^ cpu.gp_registers[info.r];
    }

    inline fn @"or"(cpu: *Cpu, info: InfoType(.@"or")) void {
        cpu.gp_registers[info.d] = cpu.gp_registers[info.d] | cpu.gp_registers[info.r];
    }

    inline fn andi(cpu: *Cpu, info: InfoType(.andi)) void {
        _ = cpu;
        std.debug.print("andi {}\n", .{info});
        @panic("andi not implemented yet!");
    }

    inline fn ori(cpu: *Cpu, info: InfoType(.ori)) void {
        _ = cpu;
        std.debug.print("ori {}\n", .{info});
        @panic("ori not implemented yet!");
    }

    // ALU Arithmetic:

    inline fn inc(cpu: *Cpu, info: InfoType(.inc)) void {
        _ = cpu;
        std.debug.print("inc {}\n", .{info});
        @panic("inc not implemented yet!");
    }

    inline fn dec(cpu: *Cpu, info: InfoType(.dec)) void {
        _ = cpu;
        std.debug.print("dec {}\n", .{info});
        @panic("dec not implemented yet!");
    }

    inline fn adc(cpu: *Cpu, info: InfoType(.adc)) void {
        _ = cpu;
        std.debug.print("adc {}\n", .{info});
        @panic("adc not implemented yet!");
    }

    inline fn add(cpu: *Cpu, info: InfoType(.add)) void {
        _ = cpu;
        std.debug.print("add {}\n", .{info});
        @panic("add not implemented yet!");
    }

    inline fn adiw(cpu: *Cpu, info: InfoType(.adiw)) void {
        _ = cpu;
        std.debug.print("adiw {}\n", .{info});
        @panic("adiw not implemented yet!");
    }

    inline fn fmul(cpu: *Cpu, info: InfoType(.fmul)) void {
        _ = cpu;
        std.debug.print("fmul {}\n", .{info});
        @panic("fmul not implemented yet!");
    }

    inline fn fmuls(cpu: *Cpu, info: InfoType(.fmuls)) void {
        _ = cpu;
        std.debug.print("fmuls {}\n", .{info});
        @panic("fmuls not implemented yet!");
    }

    inline fn fmulsu(cpu: *Cpu, info: InfoType(.fmulsu)) void {
        _ = cpu;
        std.debug.print("fmulsu {}\n", .{info});
        @panic("fmulsu not implemented yet!");
    }

    inline fn mul(cpu: *Cpu, info: InfoType(.mul)) void {
        _ = cpu;
        std.debug.print("mul {}\n", .{info});
        @panic("mul not implemented yet!");
    }

    inline fn muls(cpu: *Cpu, info: InfoType(.muls)) void {
        _ = cpu;
        std.debug.print("muls {}\n", .{info});
        @panic("muls not implemented yet!");
    }

    inline fn mulsu(cpu: *Cpu, info: InfoType(.mulsu)) void {
        _ = cpu;
        std.debug.print("mulsu {}\n", .{info});
        @panic("mulsu not implemented yet!");
    }

    inline fn neg(cpu: *Cpu, info: InfoType(.neg)) void {
        _ = cpu;
        std.debug.print("neg {}\n", .{info});
        @panic("neg not implemented yet!");
    }

    inline fn sbc(cpu: *Cpu, info: InfoType(.sbc)) void {
        _ = cpu;
        std.debug.print("sbc {}\n", .{info});
        @panic("sbc not implemented yet!");
    }

    inline fn sbci(cpu: *Cpu, info: InfoType(.sbci)) void {
        _ = cpu;
        std.debug.print("sbci {}\n", .{info});
        @panic("sbci not implemented yet!");
    }

    inline fn sbiw(cpu: *Cpu, info: InfoType(.sbiw)) void {
        _ = cpu;
        std.debug.print("sbiw {}\n", .{info});
        @panic("sbiw not implemented yet!");
    }

    inline fn sub(cpu: *Cpu, info: InfoType(.sub)) void {
        _ = cpu;
        std.debug.print("sub {}\n", .{info});
        @panic("sub not implemented yet!");
    }

    inline fn subi(cpu: *Cpu, info: InfoType(.subi)) void {
        _ = cpu;
        std.debug.print("subi {}\n", .{info});
        @panic("subi not implemented yet!");
    }

    // ALU Shifts

    inline fn asr(cpu: *Cpu, info: InfoType(.asr)) void {
        _ = cpu;
        std.debug.print("asr {}\n", .{info});
        @panic("asr not implemented yet!");
    }

    inline fn lsr(cpu: *Cpu, info: InfoType(.lsr)) void {
        _ = cpu;
        std.debug.print("lsr {}\n", .{info});
        @panic("lsr not implemented yet!");
    }

    inline fn ror(cpu: *Cpu, info: InfoType(.ror)) void {
        _ = cpu;
        std.debug.print("ror {}\n", .{info});
        @panic("ror not implemented yet!");
    }

    // I/O:

    inline fn out(cpu: *Cpu, info: InfoType(.out)) void {
        cpu.io.write(info.a, 0xFF, cpu.gp_registers[info.r]);
    }

    inline fn in(cpu: *Cpu, info: InfoType(.in)) void {
        cpu.gp_registers[info.d] = cpu.io.read(info.a);
    }

    inline fn cbi(cpu: *Cpu, info: InfoType(.cbi)) void {
        cpu.io.write(info.a, @as(u8, 1) << info.b, 0x00);
    }

    inline fn sbi(cpu: *Cpu, info: InfoType(.sbi)) void {
        cpu.io.write(info.a, @as(u8, 1) << info.b, @as(u8, 1) << info.b);
    }

    // Branching:
    inline fn brbc(cpu: *Cpu, info: InfoType(.brbc)) void {
        const pc_offset: i7 = @bitCast(info.k);
        if (!cpu.st_registers.contains(@enumFromInt(info.s))) {
            cpu.shiftProgramCounter(pc_offset);
        }
    }

    inline fn brbs(cpu: *Cpu, bits: InfoType(.brbs)) void {
        const pc_offset: i7 = @bitCast(bits.k);
        if (cpu.st_registers.contains(@enumFromInt(bits.s))) {
            cpu.shiftProgramCounter(pc_offset);
        }
    }

    inline fn sbic(cpu: *Cpu, info: InfoType(.sbic)) void {
        _ = cpu;
        std.debug.print("sbic {}\n", .{info});
        @panic("sbic not implemented yet!");
    }

    inline fn sbis(cpu: *Cpu, info: InfoType(.sbis)) void {
        _ = cpu;
        std.debug.print("sbis {}\n", .{info});
        @panic("sbis not implemented yet!");
    }

    inline fn sbrc(cpu: *Cpu, info: InfoType(.sbrc)) void {
        _ = cpu;
        std.debug.print("sbrc {}\n", .{info});
        @panic("sbrc not implemented yet!");
    }

    inline fn sbrs(cpu: *Cpu, info: InfoType(.sbrs)) void {
        _ = cpu;
        std.debug.print("sbrs {}\n", .{info});
        @panic("sbrs not implemented yet!");
    }

    // Jumps

    inline fn jmp(cpu: *Cpu, info: InfoType(.jmp)) void {
        _ = cpu;
        std.debug.print("jmp {}\n", .{info});
        @panic("jmp not implemented yet!");
    }

    inline fn rjmp(cpu: *Cpu, bits: InfoType(.rjmp)) void {
        if (@as(i12, @bitCast(bits.k)) == -1) {
            // std.log.info("this is a while(true)... exiting now", .{});
            return;
        }
        cpu.shiftProgramCounter(@as(i12, @bitCast(bits.k)));
    }

    inline fn rcall(cpu: *Cpu, info: InfoType(.rcall)) void {
        _ = cpu;
        std.debug.print("rcall {}\n", .{info});
        @panic("rcall not implemented yet!");
    }

    inline fn ret(cpu: *Cpu, info: InfoType(.ret)) void {
        _ = cpu;
        std.debug.print("ret {}\n", .{info});
        @panic("ret not implemented yet!");
    }

    inline fn reti(cpu: *Cpu, info: InfoType(.reti)) void {
        _ = cpu;
        std.debug.print("reti {}\n", .{info});
        @panic("reti not implemented yet!");
    }

    inline fn call(cpu: *Cpu, info: InfoType(.call)) void {
        _ = cpu;
        std.debug.print("call {}\n", .{info});
        @panic("call not implemented yet!");
    }

    inline fn icall(cpu: *Cpu, info: InfoType(.icall)) void {
        _ = cpu;
        std.debug.print("icall {}\n", .{info});
        @panic("icall not implemented yet!");
    }

    inline fn ijmp(cpu: *Cpu, info: InfoType(.ijmp)) void {
        _ = cpu;
        std.debug.print("ijmp {}\n", .{info});
        @panic("ijmp not implemented yet!");
    }

    inline fn eicall(cpu: *Cpu, info: InfoType(.eicall)) void {
        _ = cpu;
        std.debug.print("eicall {}\n", .{info});
        @panic("eicall not implemented yet!");
    }

    inline fn eijmp(cpu: *Cpu, info: InfoType(.eijmp)) void {
        _ = cpu;
        std.debug.print("eijmp {}\n", .{info});
        @panic("eijmp not implemented yet!");
    }

    // Comparisons

    inline fn cp(cpu: *Cpu, info: InfoType(.cp)) void {
        _ = cpu;
        std.debug.print("cp {}\n", .{info});
        @panic("cp not implemented yet!");
    }

    inline fn cpse(cpu: *Cpu, info: InfoType(.cpse)) void {
        _ = cpu;
        std.debug.print("cpse {}\n", .{info});
        @panic("cpse not implemented yet!");
    }

    inline fn cpc(cpu: *Cpu, bits: InfoType(.cpc)) void {
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
    }

    inline fn cpi(cpu: *Cpu, bits: InfoType(.cpi)) void {
        const register = regBase16(bits.d);

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
    }

    // Loads

    inline fn ldi(cpu: *Cpu, bits: InfoType(.ldi)) void {
        cpu.gp_registers[regBase16(bits.d)] = bits.k;
    }

    inline fn lac(cpu: *Cpu, info: InfoType(.lac)) void {
        _ = cpu;
        std.debug.print("lac {}\n", .{info});
        @panic("lac not implemented yet!");
    }

    inline fn las(cpu: *Cpu, info: InfoType(.las)) void {
        _ = cpu;
        std.debug.print("las {}\n", .{info});
        @panic("las not implemented yet!");
    }

    inline fn lat(cpu: *Cpu, info: InfoType(.lat)) void {
        _ = cpu;
        std.debug.print("lat {}\n", .{info});
        @panic("lat not implemented yet!");
    }

    inline fn lds(cpu: *Cpu, info: InfoType(.lds)) void {
        _ = cpu;
        std.debug.print("lds {}\n", .{info});
        @panic("lds not implemented yet!");
    }

    inline fn ldx_i(cpu: *Cpu, info: InfoType(.ldx_i)) void {
        _ = cpu;
        std.debug.print("ldx_i {}\n", .{info});
        @panic("ldx_i not implemented yet!");
    }

    inline fn ldx_ii(cpu: *Cpu, info: InfoType(.ldx_ii)) void {
        _ = cpu;
        std.debug.print("ldx_ii {}\n", .{info});
        @panic("ldx_ii not implemented yet!");
    }

    inline fn ldx_iii(cpu: *Cpu, info: InfoType(.ldx_iii)) void {
        _ = cpu;
        std.debug.print("ldx_iii {}\n", .{info});
        @panic("ldx_iii not implemented yet!");
    }

    inline fn ldy_ii(cpu: *Cpu, info: InfoType(.ldy_ii)) void {
        _ = cpu;
        std.debug.print("ldy_ii {}\n", .{info});
        @panic("ldy_ii not implemented yet!");
    }

    inline fn ldy_iii(cpu: *Cpu, info: InfoType(.ldy_iii)) void {
        _ = cpu;
        std.debug.print("ldy_iii {}\n", .{info});
        @panic("ldy_iii not implemented yet!");
    }

    inline fn ldy_iv(cpu: *Cpu, info: InfoType(.ldy_iv)) void {
        _ = cpu;
        std.debug.print("ldy_iv {}\n", .{info});
        @panic("ldy_iv not implemented yet!");
    }

    inline fn ldz_ii(cpu: *Cpu, info: InfoType(.ldz_ii)) void {
        _ = cpu;
        std.debug.print("ldz_ii {}\n", .{info});
        @panic("ldz_ii not implemented yet!");
    }

    inline fn ldz_iii(cpu: *Cpu, info: InfoType(.ldz_iii)) void {
        _ = cpu;
        std.debug.print("ldz_iii {}\n", .{info});
        @panic("ldz_iii not implemented yet!");
    }

    inline fn ldz_iv(cpu: *Cpu, info: InfoType(.ldz_iv)) void {
        _ = cpu;
        std.debug.print("ldz_iv {}\n", .{info});
        @panic("ldz_iv not implemented yet!");
    }

    inline fn lpm_i(cpu: *Cpu, info: InfoType(.lpm_i)) void {
        _ = cpu;
        std.debug.print("lpm_i {}\n", .{info});
        @panic("lpm_i not implemented yet!");
    }

    inline fn lpm_ii(cpu: *Cpu, info: InfoType(.lpm_ii)) void {
        _ = cpu;
        std.debug.print("lpm_ii {}\n", .{info});
        @panic("lpm_ii not implemented yet!");
    }

    inline fn lpm_iii(cpu: *Cpu, info: InfoType(.lpm_iii)) void {
        _ = cpu;
        std.debug.print("lpm_iii {}\n", .{info});
        @panic("lpm_iii not implemented yet!");
    }

    inline fn elpm_i(cpu: *Cpu, info: InfoType(.elpm_i)) void {
        _ = cpu;
        std.debug.print("elpm_i {}\n", .{info});
        @panic("elpm_i not implemented yet!");
    }

    inline fn elpm_ii(cpu: *Cpu, info: InfoType(.elpm_ii)) void {
        _ = cpu;
        std.debug.print("elpm_ii {}\n", .{info});
        @panic("elpm_ii not implemented yet!");
    }

    inline fn elpm_iii(cpu: *Cpu, info: InfoType(.elpm_iii)) void {
        _ = cpu;
        std.debug.print("elpm_iii {}\n", .{info});
        @panic("elpm_iii not implemented yet!");
    }

    inline fn pop(cpu: *Cpu, info: InfoType(.pop)) void {
        _ = cpu;
        std.debug.print("pop {}\n", .{info});
        @panic("pop not implemented yet!");
    }

    // Stores:

    inline fn stx_i(cpu: *Cpu, info: InfoType(.stx_i)) void {
        _ = cpu;
        std.debug.print("stx_i {}\n", .{info});
        @panic("stx_i not implemented yet!");
    }

    inline fn stx_ii(cpu: *Cpu, info: InfoType(.stx_ii)) void {
        _ = cpu;
        std.debug.print("stx_ii {}\n", .{info});
        @panic("stx_ii not implemented yet!");
    }

    inline fn stx_iii(cpu: *Cpu, info: InfoType(.stx_iii)) void {
        _ = cpu;
        std.debug.print("stx_iii {}\n", .{info});
        @panic("stx_iii not implemented yet!");
    }

    inline fn sty_ii(cpu: *Cpu, info: InfoType(.sty_ii)) void {
        _ = cpu;
        std.debug.print("sty_ii {}\n", .{info});
        @panic("sty_ii not implemented yet!");
    }

    inline fn sty_iii(cpu: *Cpu, info: InfoType(.sty_iii)) void {
        _ = cpu;
        std.debug.print("sty_iii {}\n", .{info});
        @panic("sty_iii not implemented yet!");
    }

    inline fn sty_iv(cpu: *Cpu, info: InfoType(.sty_iv)) void {
        _ = cpu;
        std.debug.print("sty_iv {}\n", .{info});
        @panic("sty_iv not implemented yet!");
    }

    inline fn stz_ii(cpu: *Cpu, info: InfoType(.stz_ii)) void {
        _ = cpu;
        std.debug.print("stz_ii {}\n", .{info});
        @panic("stz_ii not implemented yet!");
    }

    inline fn stz_iii(cpu: *Cpu, info: InfoType(.stz_iii)) void {
        _ = cpu;
        std.debug.print("stz_iii {}\n", .{info});
        @panic("stz_iii not implemented yet!");
    }

    inline fn stz_iv(cpu: *Cpu, info: InfoType(.stz_iv)) void {
        _ = cpu;
        std.debug.print("stz_iv {}\n", .{info});
        @panic("stz_iv not implemented yet!");
    }

    inline fn spm_i(cpu: *Cpu, info: InfoType(.spm_i)) void {
        _ = cpu;
        std.debug.print("spm_i {}\n", .{info});
        @panic("spm_i not implemented yet!");
    }

    inline fn spm_ii(cpu: *Cpu, info: InfoType(.spm_ii)) void {
        _ = cpu;
        std.debug.print("spm_ii {}\n", .{info});
        @panic("spm_ii not implemented yet!");
    }

    inline fn sts(cpu: *Cpu, info: InfoType(.sts)) void {
        _ = cpu;
        std.debug.print("sts {}\n", .{info});
        @panic("sts not implemented yet!");
    }

    inline fn push(cpu: *Cpu, info: InfoType(.push)) void {
        _ = cpu;
        std.debug.print("push {}\n", .{info});
        @panic("push not implemented yet!");
    }

    // Status Register

    inline fn bclr(cpu: *Cpu, info: InfoType(.bclr)) void {
        _ = cpu;
        std.debug.print("bclr {}\n", .{info});
        @panic("bclr not implemented yet!");
    }

    inline fn bld(cpu: *Cpu, info: InfoType(.bld)) void {
        _ = cpu;
        std.debug.print("bld {}\n", .{info});
        @panic("bld not implemented yet!");
    }

    inline fn bset(cpu: *Cpu, info: InfoType(.bset)) void {
        _ = cpu;
        std.debug.print("bset {}\n", .{info});
        @panic("bset not implemented yet!");
    }

    inline fn bst(cpu: *Cpu, info: InfoType(.bst)) void {
        _ = cpu;
        std.debug.print("bst {}\n", .{info});
        @panic("bst not implemented yet!");
    }

    // Others:

    inline fn des(cpu: *Cpu, info: InfoType(.des)) void {
        _ = cpu;
        std.debug.print("des {}\n", .{info});
        @panic("des not implemented yet!");
    }

    inline fn nop(cpu: *Cpu, info: InfoType(.nop)) void {
        _ = cpu;
        std.debug.print("nop {}\n", .{info});
        @panic("nop not implemented yet!");
    }

    inline fn sleep(cpu: *Cpu, info: InfoType(.sleep)) void {
        _ = cpu;
        std.debug.print("sleep {}\n", .{info});
        @panic("sleep not implemented yet!");
    }

    inline fn wdr(cpu: *Cpu, info: InfoType(.wdr)) void {
        _ = cpu;
        std.debug.print("wdr {}\n", .{info});
        @panic("wdr not implemented yet!");
    }
};

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

    pub fn read(mem: IO, addr: u6) u8 {
        return mem.vtable.readFn(mem.ctx, addr);
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    pub fn write(mem: IO, addr: u6, mask: u8, value: u8) void {
        return mem.vtable.writeFn(mem.ctx, addr, mask, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: u6) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: u6, mask: u8, value: u8) void,
    };

    pub const empty = IO{
        .ctx = null,
        .vtable = &VTable{ .readFn = emptyRead, .writeFn = emptyWrite },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u6) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn emptyWrite(ctx: ?*anyopaque, addr: u6, mask: u8, value: u8) void {
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
