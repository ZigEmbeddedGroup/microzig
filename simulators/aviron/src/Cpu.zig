const std = @import("std");
const isa = @import("isa.zig");

const Cpu = @This();

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

pc: u32 = 0,
gp_registers: [32]u8 = [1]u8{0} ** 32,
st_registers: StatusRegisters.Map = StatusRegisters.Map.initEmpty(),
io_registers: [64]u8 = [1]u8{0} ** 64,

memory: [1024 * 4]u16 = undefined,

pub fn getIndirectAddressRegister(cpu: *Cpu, which: enum { x, y, z }) *u16 {
    return @ptrCast(cpu.gp_registers[26 + @intFromEnum(which) * 2][0..2]);
}

pub fn shiftProgramCounter(cpu: *Cpu, by: i32) void {
    cpu.pc = @intCast(@as(i33, @intCast(cpu.pc)) + by);
}

pub fn run(cpu: *Cpu) !void {
    while (true) : (cpu.pc += 1) {
        const inst = isa.decode(cpu.memory[cpu.pc]) catch break;

        std.log.info(" {any}", .{inst});

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
